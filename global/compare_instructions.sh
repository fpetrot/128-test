#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Usage: ./compare_instructions.sh binary";
  exit 1;
fi

make clean
make -j$(nproc) XLEN=64 EXTRA_CFLAGS="-O3 -g"
QEMU_CPU=rv64 ./instructions_analysis.py $1 instructions_64bits

make clean
make -j$(nproc) EXTRA_CFLAGS="-O3 -g"
QEMU_CPU=x-rv128 ./instructions_analysis.py $1 instructions_128bits
