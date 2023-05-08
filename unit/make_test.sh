#!/bin/bash

# This is basically a handmade Makefile rule for a test file.

if [ -z $CPP ]; then
    echo "CPP env var not set, cannot compile test"
    exit 1
elif [ -z $CROSS_AS ]; then
    echo "CROSS_AS env var not set, cannot compile test"
    exit 1
elif [ -z $CROSS_LD ]; then
    echo "CROSS_GCC env var not set, cannot compile test"
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

if [ $1 -nt out/$baseName.o ]; then
    ${CPP} -I./common/include $1 | ${CROSS_AS} -g -o out/$baseName.o -
    ${CROSS_LD} -g -T common/link.ld out/$baseName.o -o out/$baseName
fi
