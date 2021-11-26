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
    if len(sys. argv) != 3:
        print(f'Usage: {sys.argv[0]} w|d n\n')
        sys.exit(1)

    if sys.argv[1] == 'w':
        wordsize = 32
    elif sys.argv[1] == 'd':
        wordsize = 64
    else:
        print(f'Usage: {sys.argv[0]} w|d n\n')
        sys.exit(1)

    sz = sys.argv[1]

    datacnt = int(sys.argv[2])
    if datacnt == 0:
        print(f'Usage: {sys.argv[0]} w|d n\n')
        sys.exit(1)

    datasize = 128

    data = open(f"unit_tests_i/test_shifts_reg_{sz}.S", "w")
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
        offset = int(_ * datasize/8)
        data.write(f"lq(t1, {offset}, t0)\n")
        for __ in range(-wordsize - 2, wordsize + 3):
        #for __ in range(0, wordsize):
            shamt = __&(wordsize - 1)
            v = ((values[_]&(2**wordsize - 1))<<shamt)&(2**wordsize - 1)
            sign = v>>(wordsize - 1)
            if sign == 1:
                for ___ in range(1, datasize - wordsize + 1):
                    v |= (1 << (datasize - ___))
            else:
                for ___ in range(1, datasize - wordsize + 1):
                    v &= ~(1 << (datasize - ___))
            data.write(f"li t2, {__}\n")
            if sz == 'w':
                data.write(f"sll{sz} t2, t1, t2\n")
            else:
                data.write(f"sll{sz}(t2, t1, t2)\n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffff:016x}\n")
            data.write(f"srli(t3, t2, 64)\n")
            data.write(f"//prgchk reg t3 == 0x{(v>>64)&0xffffffffffffffff:016x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        offset = int(_ * datasize/8)
        data.write(f"lq(t1, {offset}, t0)\n")
        for __ in range(-wordsize - 2, wordsize + 3):
        #for __ in range(0, wordsize):
            shamt = __&(wordsize - 1)
            # Looks as if the right shift is logical in python, ...
            v = ((values[_]&(2**wordsize - 1))>>shamt)&(2**wordsize - 1)
            # Useful only for zero shift, otherwise it is always 0
            sign = v>>(wordsize - 1)
            if sign == 1:
                for ___ in range(1, datasize - wordsize + 1):
                    v |= (1 << (datasize - ___))
            else:
                for ___ in range(1, datasize - wordsize + 1):
                    v &= ~(1 << (datasize - ___))
            data.write(f"li t2, {__}\n")
            if sz == 'w':
                data.write(f"srl{sz} t2, t1, t2\n")
            else:
                data.write(f"srl{sz}(t2, t1, t2)\n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffff:016x}\n")
            data.write(f"srli(t3, t2, 64)\n")
            data.write(f"//prgchk reg t3 == 0x{(v>>64)&0xffffffffffffffff:016x}\n")

    for _ in  range(datacnt):
        data.write(f"la t0, tab_start\n")
        offset = int(_ * datasize/8)
        data.write(f"lq(t1, {offset}, t0)\n")
        for __ in range(-wordsize - 2, wordsize + 3):
        #for __ in range(0, wordsize):
            shamt = __&(wordsize - 1)
            # Arithmetic part of the shift
            sign = (values[_]>>(wordsize - 1))&1
            v = ((values[_]&(2**wordsize - 1))>>shamt)&(2**wordsize - 1)
            # Ok, we extend the sign by ourselves, then
            if sign == 1:
                for ___ in range(1, shamt + 1):
                    v |= (1 << (wordsize - ___))
            sign = v>>(wordsize - 1)
            if sign == 1:
                for ___ in range(1, datasize - wordsize + 1):
                    v |= (1 << (datasize - ___))
            else:
                for ___ in range(1, datasize - wordsize + 1):
                    v &= ~(1 << (datasize - ___))
            data.write(f"li t2, {__}\n")
            if sz == 'w':
                data.write(f"sra{sz} t2, t1, t2\n")
            else:
                data.write(f"sra{sz}(t2, t1, t2)\n")
            data.write(f"//prgchk reg t2 == 0x{v&0xffffffffffffffff:016x}\n")
            data.write(f"srli(t3, t2, 64)\n")
            data.write(f"//prgchk reg t3 == 0x{(v>>64)&0xffffffffffffffff:016x}\n")

    data.write('j exit')
    data.close()
