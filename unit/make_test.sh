#!/bin/bash

# This is basically a handmade Makefile rule for a test file.

if [ -z $CROSS_GCC ]; then
    echo "CROSS_GCC env var not set, cannot compile test"
    exit 1
elif [ -z $CROSS_LD ]; then
    echo "CROSS_GCC env var not set, cannot compile test"
    exit 1
fi

if [ -z $1 ]; then
    echo "No test name given"
    exit 1
fi

if [ common/lib.c -nt out/lib.o ]; then
    ${CROSS_GCC} -mcmodel=medany -I./common/include -O3 -g -march=rv64imfd -mabi=lp64d -fno-math-errno -Wall -Werror -ffreestanding -c common/lib.c -o out/lib.o
fi
baseName=""
if [[ $1 == *.S ]]; then
    baseName=$(basename -s .S $(basename $1))
elif [[ $1 == *.s ]]; then
    baseName=$(basename -s .s $(basename $1))
elif [[ $1 == *.c ]]; then
    baseName=$(basename -s .c $(basename $1))
else
    echo "Unknown source file extension for $1"
    exit 1
fi
if [ $1 -nt out/$baseName.o ]; then
    ${CROSS_GCC} -g -I./common/include -x assembler-with-cpp -c $1 -o out/$baseName.o
    ${CROSS_LD} -g -T common/link.ld out/lib.o out/$baseName.o -o out/$baseName
fi
