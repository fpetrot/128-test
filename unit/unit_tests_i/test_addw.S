#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Addition with 32 bit overflow.
    li s0, 0xfedcba98

    li s1, 0x12345678

    addw s2, s0, s1
    //prgchk reg s2 == 0x11111110

    addw s2, s1, s1
    //prgchk reg s2 == 0x2468acf0

    // Add to zero (only sign extend).
    li s0, 0xffffffff
    addw s1, s0, zero
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    // Full overflow from 2**32 - 1 to 0
    li s1, 1
    addw s2, s0, s1
    //prgchk reg s2 == 0x000000000000000000000000

    // Check no-op on add to r0.
    addw zero, s0, s1
    //prgchk reg zero == 0x000000000000000000000000
    addw s0, zero, zero
    //prgchk reg s0 == 0x000000000000000000000000
    j exit
