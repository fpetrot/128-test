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

    data = open("unit_tests_b/test_zbs_imm.S", "w")
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
        data.write(f"la t0, tab_start\n")
        for __ in range(-datasize - 2, datasize + 3):
            shamt = __&0x7f
            v = values[_] | ((1 << shamt) & 0xffffffffffffffffffffffffffffffff)
            offset = int(_ * datasize/8)
            data.write(f"lq t1, {offset}(t0)\n")
            data.write(f"li t2, {__}\n")
            data.write(f"bset t2, t1, t2 \n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffffffffffffffffffff:032x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        for __ in range(-datasize - 2, datasize + 3):
            shamt = __&0x7f
            v = values[_] & ~((1 << shamt) & 0xffffffffffffffffffffffffffffffff)
            offset = int(_ * datasize/8)
            data.write(f"lq t1, {offset}(t0)\n")
            data.write(f"li t2, {__}\n")
            data.write(f"bclr t2, t1, t2 \n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffffffffffffffffffff:032x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        for __ in range(-datasize - 2, datasize + 3):
            shamt = __&0x7f
            v = values[_] ^ ((1 << shamt) & 0xffffffffffffffffffffffffffffffff)
            offset = int(_ * datasize/8)
            data.write(f"lq t1, {offset}(t0)\n")
            data.write(f"li t2, {__}\n")
            data.write(f"binv t2, t1, t2 \n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffffffffffffffffffff:032x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        for __ in range(-datasize - 2, datasize + 3):
            shamt = __&0x7f
            v = (values[_] >> shamt) & 1
            offset = int(_ * datasize/8)
            data.write(f"lq t1, {offset}(t0)\n")
            data.write(f"li t2, {__}\n")
            data.write(f"bext t2, t1, t2 \n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffffffffffffffffffff:032x}\n")

    data.write('j exit')
    data.close()
