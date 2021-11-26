#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Test sign-extend with 1 
    liu(t0, 0xfedcba9876543210)
    //prgchk reg t0 == 0xfedcba9876543210
    srli(t1, t0, 64)
    //prgchk reg t1 == 0

    addid(t1, t0, 2047)
    //prgchk reg t1 == 0xfedcba9876543a0f
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    liu(t0, 0x1234567890abcdef)

    addid(t1, t0, 2047)
    //prgchk reg t1 == 0x1234567890abd5ee
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Minimum negative value
    addid(t1, t0, -2048)
    //prgchk reg t1 == 0x1234567890abc5ef
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Add zero (sign bit = 0)
    addid(t1, t0, 0)
    //prgchk reg t1 == 0x1234567890abcdef
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Add zero (sign bit = 1)
    liu(t0, 0x8000000000000000)

    addid(t1, t0, 0)
    //prgchk reg t1 == 0x8000000000000000
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    // No-op when adding to r0
    addid(zero, t0, 2047)
    //prgchk reg zero == 0
    j exit
