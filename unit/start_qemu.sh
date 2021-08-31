#!/bin/bash
/scratch/qemu-for-upstream/build-for-upstream/riscv128-softmmu/qemu-system-riscv128 -bios none -machine virt -nographic -kernel $1 -S -s
