#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial subtraction with overflow : 0 - 1
    li t0, 0
    li t1, 1

    subd t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    // No effect subtraction : 0x1234567890abcdef - 0
    li t1, 0x1234567890abcdef

    subd t2, t1, t0
    //prgchk reg t2 == 0x1234567890abcdef

    // Destination to r0 : no effect
    subd zero, t1, t0
    //prgchk reg zero == 0

    // Subtract with self on 64 bits (with bits above 63 set)
    li t0, 0xf1234567890abcdef
    li t1, 0x01234567890abcdef
    subd t2, t1, t0
    //prgchk reg t2 == 0

    // Substract two arbitrary 64-bit values (positive result).
    li t0, 0x1337d00dcafebabe
    li t1, 0x02bed49441921aad

    subd t2, t0, t1
    //prgchk reg t2 == 0x1078fb79896ca011

    // Subtract two arbitrary 128-bit values (negative result).
    subd t2, t1, t0
    //prgchk reg t2 == 0xffffffffffffffffef87048676935fef
    j exit
