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
    if len(sys. argv) != 2:
        print(f'Usage: {sys.argv[0]} n\n')
        sys.exit(1)
    datacnt = int(sys.argv[1])
    datasize = 128

    data = open("unit_tests_i/test_shifts_imm.S", "w")
    data.write('''
#include "exit.S"
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
''')

    for _ in  range(datacnt):
        data.write(f"la s0, tab_start\n")
        # More or less randomly chosen interval
        for __ in range(datasize):
            shamt = __&(datasize - 1)
            v = (values[_]<<shamt)&0xffffffffffffffffffffffffffffffff
            offset = int(_ * datasize/8)
            data.write(f"lq s1, {offset}(s0)\n")
            data.write(f"slli s2, s1, {__} \n")
            data.write(f"//prgchk reg s2 == 0x{v&0xffffffffffffffffffffffffffffffff:032x}\n")

    for _ in  range(datacnt):
        data.write(f"la s0, tab_start\n")
        for __ in range(datasize):
            shamt = __&(datasize - 1)
            # Looks as if the right shift is logical in python, ...
            v = (values[_]>>shamt)&0xffffffffffffffffffffffffffffffff
            offset = int(_ * datasize/8)
            data.write(f"lq s1, {offset}(s0)\n")
            data.write(f"srli s2, s1, {__}\n")
            data.write(f"//prgchk reg s2 == 0x{v&0xffffffffffffffffffffffffffffffff:032x}\n")

    for _ in  range(datacnt):
        data.write(f"la s0, tab_start\n")
        for __ in range(datasize):
            shamt = __&(datasize - 1)
            sign = values[_]>>127
            v = (int(values[_]>>shamt))&0xffffffffffffffffffffffffffffffff
            # Ok, we extend the sign by ourselves, then
            if sign == 1:
                for ___ in range(1, shamt + 1):
                    v |= (1 << (128 - ___))
            offset = int(_ * datasize/8)
            data.write(f"lq s1, {offset}(s0)\n")
            data.write(f"srai s2, s1, {__} \n")
            data.write(f"//prgchk reg s2 == 0x{v&0xffffffffffffffffffffffffffffffff:032x}\n")

    data.write('j exit')
    data.close()
