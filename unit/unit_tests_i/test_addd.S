#include "insns.S"
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:

    // Addition with 64 bit overflow.
    liu t0, 0xfedcba9876543210
    //prgchk reg t0 == 0xfedcba9876543210

    liu t1, 0x1234567890abcdef
    //prgcheck reg t1 == 0x1234567890abcdef

    addd t2, t0, t0
    //prgchk reg t2 == 0x1fdb97530eca864202468acf121579bd

    // Add to zero (only sign extend).
    liu t0, 0xffffffffffffffffffffffffffffffff
    addd t1, t0, zero
    //prgchk reg t1 == 0xffffffffffffffffffffffffffffffff

    // Full overflow from 2**64 - 1 to 0
    liu t1, 0x100000000000000000000000000000000
    addd t2, t0, t1
    //prgchk reg t2 == 0x0

    // Check no-op on add to r0.
    addd zero, t0, t0
    //prgchk reg zero == 0
    addd t0, zero, zero
    //prgchk reg t0 == 0
    j exit
