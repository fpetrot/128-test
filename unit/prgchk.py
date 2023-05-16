#!/usr/bin/env python3

import sys
import os
import re
import subprocess

from typing import Callable, Dict, List, NamedTuple, Optional

from vars import CROSS_GCC, CROSS_GDB, QEMU_EXEC, CROSS_LD, CROSS_AS, CPP
from enum import auto, Enum

chk_comm_re = re.compile(r"//prgchk")

class TestStatus(Enum):
    COMPILE_ERROR = auto()
    CHECK_PARSE_ERROR = auto()
    EMULATION_ERROR = auto()
    CHECK_FAILURE = auto()
    NO_CHECK_IN_FILE = auto()
    SUCCESS = auto()

    def __bool__(self):
        return self == TestStatus.SUCCESS

def smart_int_cast(intstr: str) -> int:
    intstr = intstr.strip()
    if intstr.startswith('0x'):
        return int(intstr[2:], 16)
    elif intstr.startswith('0b'):
        return int(intstr[2:], 2)
    else:
        return int(intstr)

op_opposite = {
    '==': '!=',
    '!=': '==',
    '<': '>=',
    '>': '<=',
    '<=': '>',
    '>=': '<'
}

class colors:
    GOOD = '\033[96m'
    WHAT = '\033[33m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

class CheckParseArgs(NamedTuple):
    lineno: int
    srcfile: str
    chkargs: List[str]

def parse_regchk(a: CheckParseArgs) -> str:
    if len(a.chkargs) != 3:
        return None
    reg = a.chkargs[0]
    op = a.chkargs[1]
    val = smart_int_cast(a.chkargs[2])
    return f'''
break {a.srcfile}:{a.lineno} if ${reg} {op_opposite[op]} {val}
commands
silent
    output "Register check failed line {a.lineno}, expected {reg} {op} {val} (= {hex(val)}), got :"
    output/x ${reg}
    kill
    quit 1
end
'''

def parse_varchk(a: CheckParseArgs) -> str:
    if len(a.chkargs) != 3:
        return None
    varname = a.chkargs[0]
    op = a.chkargs[1]
    val = smart_int_cast(a.chkargs[2])
    return f'''
break {a.srcfile}:{a.lineno} if ((unsigned long){varname}) {op_opposite[op]} {val}
commands
silent
    output "Variable value check condition broken line {a.lineno}, expected {varname} {op} {val}, got :"
    print /x (unsigned long){varname}
    kill
    quit 1
end
'''

def parse_gdbchk(a: CheckParseArgs) -> str:
    expr = " ".join(a.chkargs)
    return f'''
break {a.srcfile}:{a.lineno} if !({expr})
commands
silent
    print "GDB check condition broken line {a.lineno}, expected {expr} true, but was false"
    kill
    quit 1
end
'''

def parse_errchk(a: CheckParseArgs) -> str:
    msg = "\"" + " ".join(a.chkargs) + "\""
    return f'''
break {a.srcfile}:{a.lineno}
commands
silent
    print "Error line {a.lineno}: {msg}"
    kill
    quit 1
end
'''

def parse_msgchk(a: CheckParseArgs) -> str:
    msg = " ".join(a.chkargs)
    return f'''
break {a.srcfile}:{a.lineno}
commands
silent
    print "Info line {a.lineno}: {msg}"
    continue
end
'''

chk_parsers: Dict[str, Callable[[CheckParseArgs], Optional[str]]] = {
    'reg': parse_regchk,
    'var': parse_varchk,
    'gdb': parse_gdbchk,
    'err': parse_errchk,
    'msg': parse_msgchk
}

def parse_check(line: str, lineno: int, base_filename: str) -> Optional[str]:
    line = line.strip()
    parts = line.split()
    if len(parts) < 2:
        return None
    cmd = parts[1]

    if cmd in chk_parsers:
        parser = chk_parsers[cmd]
        genchk = parser(CheckParseArgs(lineno, base_filename, parts[2:]))
        return genchk
    else:
        print(f"Unknown check {cmd} at {base_filename}:{lineno}")

def generate_gdb_script(src_filename: str) -> TestStatus:
    src_file = open(src_filename, "r")
    base_filename = os.path.basename(src_filename)
    gdb_script_file = open(f"out/{base_filename}.gdb", "w")

    gdb_script_file.write("set logging enable off\ntarget remote :1144\n")

    nchecks = 0
    for lineno, line in enumerate(src_file):
        if chk_comm_re.match(line.strip()) is not None:
            gdbline = parse_check(line, lineno + 1, base_filename)
            if gdbline is None:
                return TestStatus.CHECK_PARSE_ERROR
            nchecks += 1

            gdb_script_file.write(gdbline)

    # GDB will disconnect from QEMU, so we cannot execute anything
    # after continue
    # On disconnection, return value is 0, on bp test failure 1, lucky us
    gdb_script_file.write("\ncontinue\n")

    gdb_script_file.close()
    src_file.close()

    return (TestStatus.SUCCESS if nchecks != 0 else TestStatus.NO_CHECK_IN_FILE)


def run_test(test_filename: str, silent: bool = True) -> TestStatus:
    test_name = os.path.splitext(os.path.basename(test_filename))[0]

    os.environ['CROSS_GCC'] = CROSS_GCC
    os.environ['CPP'] = CPP
    os.environ['CROSS_AS'] = CROSS_AS
    os.environ['CROSS_LD'] = CROSS_LD
    make = subprocess.run(['./make_test.sh', f'{test_filename}'], stdout=(open("/dev/null") if silent else sys.stdout))
    if make.returncode != 0:
        print(make, end=" ")
        return TestStatus.COMPILE_ERROR

    gdbgen_status = generate_gdb_script(test_filename)
    if not gdbgen_status:
        return gdbgen_status

    qemu = subprocess.Popen([QEMU_EXEC, '-machine', 'virt', '-cpu', 'x-rv128', '-accel', 'tcg,thread=single', '-bios', 'none', '-machine', 'virt', '-nographic',
        '-kernel', f'out/{test_name}', '-S', '-gdb', 'tcp::1144'], stdout=(open("/dev/null") if silent else sys.stdout))
    gdb = subprocess.run(f"{CROSS_GDB} -q out/{test_name} < out/{os.path.basename(test_filename)}.gdb", shell=True, stdout=(open("/dev/null") if silent else sys.stdout), stderr=(open("/dev/null") if silent else sys.stderr))
    test_retval = gdb.returncode

    qemu_retval = qemu.wait()

    if qemu_retval != 0:
        return TestStatus.EMULATION_ERROR

    if test_retval != 0:
        return TestStatus.CHECK_FAILURE

    return TestStatus.SUCCESS

def print_status(status: TestStatus):
    if status == TestStatus.SUCCESS:
        print(colors.GOOD, status.name, colors.ENDC)
    elif status == TestStatus.CHECK_FAILURE:
        print(colors.FAIL, status.name, colors.ENDC)
    else:
        print(colors.WHAT, status.name, colors.ENDC)

if __name__ == "__main__":
    if len(sys.argv) == 1 or len(sys.argv) > 3:
        print(f"Usage : {sys.argv[0]} [-q] <test_file>")
        exit(0)

    if sys.argv[1] == "-q":
        silent = True
        test_filename = sys.argv[2]
    else:
        silent = False
        test_filename = sys.argv[1]

    # Make sure the output directory is create before going further
    if not os.path.exists("out"):
        os.makedirs("out")

    print(f"Test {os.path.splitext(os.path.basename(test_filename))[0]} : ", end="")
    status = run_test(test_filename, silent=silent)

    print_status(status)

    exit(0 if status else 1)
