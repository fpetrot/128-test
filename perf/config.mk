# Common variables for all tests (toolchain, flags, etc...).

# Compiler should be the same for all three arches.
CROSS_GCC=riscv64-unknown-elf-gcc
CROSS_GCC_128=$(CROSS_GCC)
CROSS_GCC_64=$(CROSS_GCC)
CROSS_GCC_32=$(CROSS_GCC)

# Need a specific linker for RV32.
CROSS_LD=riscv64-unknown-elf-ld
CROSS_LD_128=$(CROSS_LD)
CROSS_LD_64=$(CROSS_LD)
CROSS_LD_32=$(CROSS_LD) -m elf32lriscv

CFLAGS=-I../common/include -O0 -g

QEMU128=qemu-system-riscv64 -cpu x-rv128 -accel tcg,thread=single
QEMU64=qemu-system-riscv64
QEMU32=qemu-system-riscv32

CFLAGS_32=-march=rv32imafc -mabi=ilp32f
CFLAGS_64=-march=rv64imafdc -mabi=lp64d
CFLAGS_128=$(CFLAGS_64)
