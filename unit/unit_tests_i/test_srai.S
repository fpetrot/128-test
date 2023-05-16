#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0xffffffffffffffff
    li t1, 0xffffffffffffffffffffffffffffffff

    srai t2, t1, 64
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff
    srai t2, t2, 64
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    // Check that a shift with 64-bit sign bit doesn't carry it (not a 64 bit srai).
    srai t2, t0, 32
    //prgchk reg t2 == 0xffffffff

    // Check that a shift with 32-bit sign bit doesn't carry it (not a 32-bit srai).
    li t0, 0xffffffff
    srai t2, t0, 16
    //prgchk reg t2 == 0xffff

    // Check max shift value, and carry of sign bit.
    // Sign bit = 1
    li t0, 0x80000000000000000000000000000000
    srai t2, t1, 127
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff
    
    // Sign bit = 0
    li t0, 0x70000000000000000000000000000000
    srai t2, t1, 127
    //prgck reg t2 == 0
    j exit
