#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Addition with 32 bit overflow.
    liu(t0, 0xfedcba98)
    //prgchk reg t0 == 0xfedcba98

    liu(t1, 0x12345678)
    //prgcheck reg t1 == 0x12345678

    addw t2, t0, t1
    //prgchk reg t2 == 0x11111110
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    addw t2, t1, t1
    //prgchk reg t2 == 0x2468acf0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Add to zero (only sign extend).
    liu(t0, 0xffffffff)
    addw t1, t0, zero
    //prgchk reg t1 == 0xffffffffffffffff
    srli(t2, t1, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Full overflow from 2**32 - 1 to 0
    liu(t1, 1)
    addw t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Check no-op on add to r0.
    addw zero, t0, t1
    //prgchk reg zero == 0
    addw t0, zero, zero
    //prgchk reg t0 == 0
    j exit
