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

    data = open("unit_tests_i/test_shifts_reg.S", "w")
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
''')


    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        # More or less randomly chosen interval
        for __ in range(-datasize - 2, datasize + 3):
            shamt = __&0x7f
            v = (values[_]<<shamt)&0xffffffffffffffffffffffffffffffff
            data.write(f"li t2, {__}\n")
            offset = int(_ * datasize/8)
            data.write(f"lq(t1, {offset}, t0)\n")
            data.write(f"sll t2, t1, t2\n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffff:016x}\n")
            data.write(f"srli(t3, t2, 64)\n")
            data.write(f"//prgchk reg t3 == 0x{(v>>64)&0xffffffffffffffff:016x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        for __ in range(-datasize - 2, datasize + 3):
            shamt = __&0x7f
            # Looks as if the right shift is logical in python, ...
            v = (values[_]>>shamt)&0xffffffffffffffffffffffffffffffff
            data.write(f"li t2, {__}\n")
            offset = int(_ * datasize/8)
            data.write(f"lq(t1, {offset}, t0)\n")
            data.write(f"srl t2, t1, t2\n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffff:016x}\n")
            data.write(f"srli(t3, t2, 64)\n")
            data.write(f"//prgchk reg t3 == 0x{(v>>64)&0xffffffffffffffff:016x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        for __ in range(-datasize - 2, datasize + 3):
            shamt = __&0x7f
            sign = values[_]>>127
            v = (int(values[_]>>shamt))&0xffffffffffffffffffffffffffffffff
            # Ok, we extend the sign by ourselves, then
            if sign == 1:
                for ___ in range(1, shamt + 1):
                    v |= (1 << (128 - ___))
            data.write(f"li t2, {__}\n")
            offset = int(_ * datasize/8)
            data.write(f"lq(t1, {offset}, t0)\n")
            data.write(f"sra t2, t1, t2\n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffff:016x}\n")
            data.write(f"srli(t3, t2, 64)\n")
            data.write(f"//prgchk reg t3 == 0x{(v>>64)&0xffffffffffffffff:016x}\n")

    data.write('j exit')
    data.close()
