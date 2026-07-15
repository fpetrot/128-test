#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0xffffffffffffffff
    li s1, 0xffffffffffffffffffffffffffffffff

    srai s2, s1, 64
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff
    srai s2, s2, 64
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // Check that a shift with 64-bit sign bit doesn't carry it (not a 64 bit srai).
    srai s2, s0, 32
    //prgchk reg s2 == 0xffffffff

    // Check that a shift with 32-bit sign bit doesn't carry it (not a 32-bit srai).
    li s0, 0xffffffff
    srai s2, s0, 16
    //prgchk reg s2 == 0xffff

    // Check max shift value, and carry of sign bit.
    // Sign bit = 1
    li s0, 0x80000000000000000000000000000000
    srai s2, s1, 127
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff
    
    // Sign bit = 0
    li s0, 0x70000000000000000000000000000000
    srai s2, s1, 127
    //prgck reg s2 == 0
    j exit
