#!/bin/bash

# This is basically a handmade Makefile rule for a test file.

if [ -z $CROSS_GCC ]; then
    echo "CROSS_GCC env var not set, cannot compile test"
    exit 1
elif [ -z $CROSS_LD ]; then
    echo "CROSS_LD env var not set, cannot compile test"
    exit 1
fi

if [ -z $1 ]; then
    echo "No test name given"
    exit 1
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

mkdir -p ./out
# For some weird reason in some cases python subprocess;run closes stdout before
# we got a chance to write something, so check that before echoing
if [ common/lib.c -nt out/lib.o ]; then
    ${CROSS_GCC} -march=rv128imfd_zicsr_zicboz_zicbom_zba_zbb_zbs -g -I./common/include -c common/lib.c -o out/lib.o
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi
if [ $1 -nt out/$baseName.o ]; then
    ${CROSS_GCC} -march=rv128imfd_zicsr_zicboz_zicbom_zba_zbb_zbs -g -I./common/include -x assembler-with-cpp -c $1 -o out/$baseName.o
    if [ $? -ne 0 ]; then
        exit 1
    fi
    ${CROSS_LD} -g -T common/link.ld out/lib.o out/$baseName.o -o out/$baseName
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

# Make sure we return a correct status
exit 0
