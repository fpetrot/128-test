#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Addition with 64 bit overflow.
    liu s0, 0xfedcba9876543210 
    //prgchk reg s0 == 0xfedcba9876543210

    liu s1, 0x1234567890abcdef
    //prgcheck reg s1 == 0x1234567890abcdef

    caddd(s0, s1)
    //prgchk reg s0 == 0x00000000000000001111111106ffffff


    caddd(s1, s1)
    //prgchk reg a0 == 0x00000000000000002468acf121579bde
    // Add to zero (only sign extend).
    liu s0, 0xffffffffffffffff
    li s1, 0
    caddd(s1, s0)
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    // Full overflow from 2**64 - 1 to 0
    liu s1, 1z
    caddd(s0, s1)
    //prgchk reg s0 == 0

    j exit
