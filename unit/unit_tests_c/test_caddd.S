#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Addition with 64 bit overflow.
    li s0, 0xfedcba9876543210 
    //prgchk reg s0 == 0xfedcba9876543210

    li s1, 0x1234567890abcdef
    //prgcheck reg s1 == 0x1234567890abcdef

    c.addd s0, s1
    //prgchk reg s0 == 0x00000000000000001111111106ffffff


    c.addd s1, s1
    //prgchk reg a0 == 0x00000000000000002468acf121579bde
    // Add to zero (only sign extend).
    li s0, 0xffffffffffffffff
    li s1, 0
    c.addd s1, s0
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    // Full overflow from 2**64 - 1 to 0
    li s1, 1
    c.addd s0, s1
    //prgchk reg s0 == 0

    j exit
