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
    return f"""
break {a.srcfile}:{a.lineno} if ${reg} {op_opposite[op]} {val}
commands
silent
    info line
    print "Register check condition broken, expected {reg} {op} {val} (= {hex(val)}), got :"
    print /x ${reg}
    kill
    quit 1
end
        """

def parse_varchk(a: CheckParseArgs) -> str:
    if len(a.chkargs) != 3:
        return None
    varname = a.chkargs[0]
    op = a.chkargs[1]
    val = smart_int_cast(a.chkargs[2])
    return f"""
break {a.srcfile}:{a.lineno} if ((unsigned long) {varname}) {op_opposite[op]} {val}
commands
silent
    info line
    print "Variable value check condition broken, expected {varname} {op} {val}, got :"
    print /x (unsigned long) {varname}
    kill
    quit 1
end
        """

def parse_gdbchk(a: CheckParseArgs) -> str:
    expr = " ".join(a.chkargs)
    return f"""
break {a.srcfile}:{a.lineno} if !({expr})
commands
silent
    info line
    print "GDB check condition broken, expected {expr} true, but was false"
    kill
    quit 1
end
    """

def parse_errchk(a: CheckParseArgs) -> str:
    msg = "\"" + " ".join(a.chkargs) + "\""
    return f"""   
break {a.srcfile}:{a.lineno}
commands
silent
    info line
    print {msg}
    kill
    quit 1
end
    """
    
def parse_msgchk(a: CheckParseArgs) -> str:
    msg = " ".join(a.chkargs)
    return f"""   
break {a.srcfile}:{a.lineno}
commands
silent
    info line
    print {msg}
    continue
end
    """

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

    gdb_script_file = open(f"out/{base_filename}.gdbcmd", "w")

    gdb_script_file.write("set logging enable off\ntarget remote :1144\n")

    nchecks = 0
    for lineno, line in enumerate(src_file):
        if chk_comm_re.match(line.strip()) is not None:
            gdbline = parse_check(line, lineno + 1, base_filename)
            if gdbline is None:
                return TestStatus.CHECK_PARSE_ERROR
            nchecks += 1

            gdb_script_file.write(gdbline)

    gdb_script_file.write("continue\nquit 0")
    
    gdb_script_file.close()
    src_file.close()

    return (TestStatus.SUCCESS if nchecks != 0 else TestStatus.NO_CHECK_IN_FILE)


def run_test(test_filename: str, silent: bool = True) -> TestStatus:
    test_name = os.path.splitext(os.path.basename(test_filename))[0]

    os.environ['CROSS_GCC'] = CROSS_GCC
    os.environ['CPP'] = CPP
    os.environ['CROSS_AS'] = CROSS_AS
    os.environ['CROSS_LD'] = CROSS_LD
    retval = os.system(f"./make_test.sh {test_filename} {'&> /dev/null' if silent else ''}")
    if retval != 0:
        return TestStatus.COMPILE_ERROR

    gdbgen_status = generate_gdb_script(test_filename)
    if not gdbgen_status:
        return gdbgen_status

    qemuproc = subprocess.Popen([QEMU_EXEC, '-machine', 'virt', '-cpu', 'x-rv128', '-accel', 'tcg,thread=single', '-bios', 'none', '-machine', 'virt', '-nographic',
        '-kernel', f'out/{test_name}', '-S', '-gdb', 'tcp::1144'], stdout=(open("/dev/null") if silent else sys.stdout))
    test_retval = os.system(f"{CROSS_GDB} -q out/{test_name} < out/{os.path.basename(test_filename)}.gdbcmd {' &> /dev/null' if silent else ''}")

    qemu_retval = qemuproc.wait()

    if qemu_retval != 0:
        return TestStatus.EMULATION_ERROR

    if test_retval != 0:
        return TestStatus.CHECK_FAILURE

    return TestStatus.SUCCESS

if __name__ == "__main__":
    if len(sys.argv) == 1:
        print(f"Usage : {sys.argv[0]} <test_file>")
        exit(0)
    
    test_filename = sys.argv[1]
    
    print(f"Test {os.path.splitext(os.path.basename(test_filename))[0]} : ", end="")
    status = run_test(test_filename, silent=False)

    print(status.name)

    exit(0 if status else 1)
