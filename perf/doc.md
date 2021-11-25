# Functional Tests
These tests are small asm programs that run on the 32, 64 and 128-bit versions of the RISC-V processor in QEMU

## Configuration & Usage
Change the CROSS and QEMU variables in ./config.mk so that it points to a riscv compiler supporting 32 and 64 bit.
Cd into a test directory and launch `make run32` to compile and run the 32-bit version of the test, and identically `make run64` or `make run128` to run the 64 and 128-bit versions.

The Makefiles are not so clean neither fully factorized (to say the less) because this was really use as checks during development and not integrated nicely into a test framework.

## Warning
The “version” of the test has to be in sync with the version of the qemu-riscv128 repo to work well.
Version tag v6 is compatible with branch v6 (https://github.com/fpetrot/qemu-riscv128/tree/v6).
