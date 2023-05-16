#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Addition with 64 bit overflow.
    li t0, 0xfedcba9876543210
    //prgchk reg t0 == 0xfedcba9876543210

    li t1, 0x1234567890abcdef
    //prgchk reg t1 == 0x1234567890abcdef

    addd t2, t0, t1
    //prgchk reg t2 == 0x1111111106ffffff

    addd t2, t1, t1
    //prgchk reg t2 == 0x2468acf121579bde

    // Add to zero (only sign extend).
    li t0, 0xffffffffffffffff
    //prgchk reg t0 == 0xffffffffffffffff
    addd t1, t0, zero
    //prgchk reg t1 == 0xffffffffffffffffffffffffffffffff

    // Full overflow from 2**64 - 1 to 0
    li t1, 1
    addd t2, t0, t1
    //prgchk reg t2 == 0

    // Check no-op on add to r0.
    addd zero, t0, t1
    //prgchk reg zero == 0
    addd t0, zero, zero
    //prgchk reg t0 == 0
    j exit
