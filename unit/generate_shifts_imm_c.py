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

    data = open("unit_tests_c/test_shifts_imm.S", "w")
    data.write('#include "exit.S"\n')
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
.option rvc
.section .text.init,"ax",@progbits
.globl _start
_start:
''')

    # Possible registers to compress shift are
    # x8 to x15, or s0, s1, a0, ..., a5
    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        # Compress 128-bit left shift ranges from 1 to 64, inclusive
        for __ in range(1, 65):
            shamt = __
            v = (values[_]<<shamt)&0xffffffffffffffffffffffffffffffff
            offset = int(_ * datasize/8)
            data.write(f"lq s0, {offset}(t0)\n")
            data.write(f"c.slli s0, {__}\n")
            data.write(f"//prgchk reg s0 == 0x{v:032x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        for __ in list(range(1,32)) + [64] + list(range(96, 128)):
            shamt = __
            # Looks as if the right shift is logical in python, ...
            v = (values[_]>>shamt)&0xffffffffffffffffffffffffffffffff
            offset = int(_ * datasize/8)
            data.write(f"lq a0, {offset}(t0)\n")
            data.write(f"c.srli a0, {__}\n")
            data.write(f"//prgchk reg a0 == 0x{v:032x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        for __ in list(range(1,32)) + [64] + list(range(96, 128)):
            shamt = __
            sign = values[_]>>127
            v = (int(values[_]>>shamt))&0xffffffffffffffffffffffffffffffff
            # Ok, we extend the sign by ourselves, then
            if sign == 1:
                for ___ in range(1, shamt + 1):
                    v |= (1 << (128 - ___))
            offset = int(_ * datasize/8)
            data.write(f"lq a5, {offset}(t0)\n")
            data.write(f"c.srai a5, {__}\n")
            data.write(f"//prgchk reg a5 == 0x{v:032x}\n")

    data.write('j exit\n')
    data.close()
