#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Addition with 64 bit overflow.
    liu(s0, 0xfedcba9876543210)
    //prgchk reg s0 == 0xfedcba9876543210

    liu(s1, 0x1234567890abcdef)
    //prgcheck reg s1 == 0x1234567890abcdef

    caddd(s0, s1)
    //prgchk reg s0 == 0x1111111106ffffff
    srli(a0, s0, 64)
    //prgchk reg a0 == 0

    caddd(s1, s1)
    //prgchk reg a0 == 0x2468acf121579bde
    srli(s1, s1, 64)
    //prgchk reg s1 == 0

    // Add to zero (only sign extend).
    liu(s0, 0xffffffffffffffff)
    li s1, 0
    caddd(s1, s0)
    //prgchk reg s1 == 0xffffffffffffffff
    srli(s2, s1, 64)
    //prgchk reg s2 == 0xffffffffffffffff

    // Full overflow from 2**64 - 1 to 0
    liu(s1, 1)
    caddd(s0, s1)
    //prgchk reg s0 == 0
    srli(s0, s0, 64)
    //prgchk reg s0 == 0

    j exit
