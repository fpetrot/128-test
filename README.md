# 128-test
Some unit and functional tests for 128-bit (and 64 and 32) riscv

‘unit’ contains test generators for various instructions, in particular 128-bit shifts

'int128' contains random tests to check the 128-bit implementation of div[su]/rem[su]

'perf' contains some functional tests that might be used to check the performance behavior of the various riscv flavors

'kernel' contains an extremely basic operating system kernel for rv128 (works on https://github.com/fpetrot/qemu-riscv128/tree/rv128+satp)

The pathes to the qemu executables are hard coded depending on which machine I perform the test, which is bad, but this is no production software, ...
