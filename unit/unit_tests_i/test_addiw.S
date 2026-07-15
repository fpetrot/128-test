#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Test signext to 128 bits
    li s0, 0x80000000
    addiw s0, s0, 0
    //prgchk reg s0 == 0xffffffffffffffffffffffff80000000

    // Test basic addition's result (no overflow)
    li s0, 0x1dcd8c46
    addiw s0, s0, 1984
    //prgchk reg s0 == 0x00000000000000001dcd9406

    // Test basic addition's result (that overflows in bit 33)
    li s0, 0xfffffffe
    addiw s0, s0, 2047
    //prgchk reg s0 == 0x0000000000000000000007fd

    // Addition with overflow into sign bit.
    li s0, 0x7fffffff
    addiw s0, s0, 1
    //prgchk reg s0 == 0xffffffffffffffffffffffff80000000
    j exit
