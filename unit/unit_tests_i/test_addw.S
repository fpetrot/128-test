#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Addition with 32 bit overflow.
    li t0, 0xfedcba98

    li t1, 0x12345678

    addw t2, t0, t1
    //prgchk reg t2 == 0x11111110

    addw t2, t1, t1
    //prgchk reg t2 == 0x2468acf0

    // Add to zero (only sign extend).
    li t0, 0xffffffff
    addw t1, t0, zero
    //prgchk reg t1 == 0xffffffffffffffffffffffffffffffff

    // Full overflow from 2**32 - 1 to 0
    li t1, 1
    addw t2, t0, t1
    //prgchk reg t2 == 0x000000000000000000000000

    // Check no-op on add to r0.
    addw zero, t0, t1
    //prgchk reg zero == 0x000000000000000000000000
    addw t0, zero, zero
    //prgchk reg t0 == 0x000000000000000000000000
    j exit
