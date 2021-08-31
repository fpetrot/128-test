#!/bin/env python3

import sys
from random import randint

_typedir = {
    128: '.octa',
    64: '.dword',
    32: '.word'
}

if __name__ == "__main__":
    datacnt = int(sys.argv[1])
    datasize = int(sys.argv[2])

    data = open("data.S", "w")
    data.write(".section .data\n")
    data.write(f"tab_size: {_typedir[datasize]} {hex(datacnt)}\n")
    data.write("tab_start:\n")
    for _ in range(datacnt):
        data.write(f"{_typedir[datasize]} {hex(randint(0, 2**datasize - 1))}\n")

    data.close()