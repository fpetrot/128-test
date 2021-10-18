#!/bin/env python3

# Full range testing of the register to register 128-bit shifts
# First argument is the number of random numbers to draw, above
# 2 you have a good chance to have positive and negative numbers
# for testing the right arithmetic shift

import sys
from random import randint

_typedir = {
    128: '.octa',
    64: '.dword',
    32: '.word'
}

if __name__ == "__main__":
    datacnt = int(sys.argv[1])
    datasize = 128

    data = open("unit_tests_b/test_ror_imm.S", "w+")
    data.write('''
#include "insns.S" 
#include "utils.S"
''')
    data.write(".section .data\n")
    data.write(f"tab_size: {_typedir[datasize]} {datacnt}\n")
    data.write("tab_start:\n")
    values = []
    for _ in range(datacnt):
        values.append(randint(0, 2**datasize - 1))
        data.write(f"{_typedir[datasize]} 0x{values[_]:032x}\n")
        data.write(f"#0b{values[_]:0128b}\n")

    data.write(".section .text\n")
    data.write('''
.section .text.init,"ax",@progbits
.globl _start
_start:
la      sp, _memory_end
j main
main:
''')

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        # More or less randomly chosen interval
        for __ in range(-2, 129):
            shamt = __&0x7f
            v0 = (values[_]>>shamt)&0xffffffffffffffffffffffffffffffff
            v1 = (values[_]<<(128 - shamt))&0xffffffffffffffffffffffffffffffff
            v = v1 | v0
            offset = int(_ * datasize/8)
            data.write(f"lq(t1, {offset}, t0)\n")
            data.write(f"rori(t2, t1, {__})\n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffff:016x}\n")
            data.write(f"srli(t3, t2, 64)\n")
            data.write(f"//prgchk reg t3 == 0x{(v>>64)&0xffffffffffffffff:016x}\n")

    data.write('j exit')
    data.close()
