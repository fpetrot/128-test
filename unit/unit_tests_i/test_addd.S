#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Addition with 64 bit overflow.
    li s0, 0xfedcba9876543210
    //prgchk reg s0 == 0xfedcba9876543210

    li s1, 0x1234567890abcdef
    //prgchk reg s1 == 0x1234567890abcdef

    addd s2, s0, s1
    //prgchk reg s2 == 0x1111111106ffffff

    addd s2, s1, s1
    //prgchk reg s2 == 0x2468acf121579bde

    // Add to zero (only sign extend).
    li s0, 0xffffffffffffffff
    //prgchk reg s0 == 0xffffffffffffffff
    addd s1, s0, zero
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    // Full overflow from 2**64 - 1 to 0
    li s1, 1
    addd s2, s0, s1
    //prgchk reg s2 == 0

    // Check no-op on add to r0.
    addd zero, s0, s1
    //prgchk reg zero == 0
    addd s0, zero, zero
    //prgchk reg s0 == 0
    j exit
