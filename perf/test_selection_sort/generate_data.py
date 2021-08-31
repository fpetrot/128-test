#!/bin/env python3

import os
import sys
import math
import random

def error (msg, code=1):
    sys.stderr.write(msg)
    sys.exit(code)

cmdname = os.path.basename(sys.argv[0])

if len(sys.argv) != 3:
    error("usage: %s tabsize 32|64|128\n" % cmdname)

size = int(sys.argv[1])
itemsize = int(sys.argv[2])

if itemsize != 32 and itemsize != 64 and itemsize != 128:
    error("usage: %s tabsize 32|64|128\n" % cmdname)

# Put zat in bytes
itemsize = itemsize/8

if itemsize == 16:
    only_low = False
    only_high = False

    if only_low is True and only_high is True:
        error("set 'only' variables as expected plize!")

if itemsize == 8 or itemsize == 16:
    program_string=""".data
    .global tableau
    .align 4
    donnee_programme: # in that order : 1, size, shamt, size - 1 on 128 or 64 bits
    .dword 0x0000000000000001"""                               + ['', ", 0x0000000000000000"][itemsize == 16] + """
    .dword 0x""" + hex(size)[2:].zfill(16)                     + ['', ", 0x0000000000000000"][itemsize == 16] + """
    .dword 0x""" + hex(int(math.log2(itemsize)))[2:].zfill(16) + ['', ", 0x0000000000000000"][itemsize == 16] + """
    .dword 0x""" + hex(size-1)[2:].zfill(16)                   + ['', ", 0x0000000000000000"][itemsize == 16] + """
    .align 4
    tableau:"""
    print(program_string)
    for i in range(0,size):
        n = random.randint(0,2**64)
        if itemsize == 16:
            p = random.randint(0,2**64)
            if only_high is True:
                print('.dword 0x' + hex(0)[2:].zfill(16) + ', 0x' + hex(p)[2:].zfill(16))
                continue
            if only_low is True:
                print('.dword 0x' + hex(n)[2:].zfill(16) + ', 0x' + hex(0)[2:].zfill(16))
                continue
            print('.dword 0x' + hex(n)[2:].zfill(16) + ', 0x' + hex(p)[2:].zfill(16))
        else:
            print('.dword 0x' + hex(n)[2:].zfill(16))
else:
    program_string=""".data
    .global tableau
    .align 4
    donnee_programme: # in that order : 1, size, shamt, size - 1 on 128 or 64 bits
    .word 0x00000001
    .word 0x""" + hex(size)[2:].zfill(8) + """
    .word 0x""" + hex(int(math.log2(itemsize)))[2:].zfill(8) + """
    .word 0x""" + hex(size-1)[2:].zfill(8) + """
    .align 4
    tableau:"""
    print(program_string)
    for i in range(0,size):
        n = random.randint(0,2**32)
        print('.word 0x' + hex(n)[2:].zfill(8))
print('#define TYPESIZE ', int(itemsize))
