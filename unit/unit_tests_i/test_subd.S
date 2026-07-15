#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial subtraction with overflow : 0 - 1
    li s0, 0
    li s1, 1

    subd s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // No effect subtraction : 0x1234567890abcdef - 0
    li s1, 0x1234567890abcdef

    subd s2, s1, s0
    //prgchk reg s2 == 0x1234567890abcdef

    // Destination to r0 : no effect
    subd zero, s1, s0
    //prgchk reg zero == 0

    // Subtract with self on 64 bits (with bits above 63 set)
    li s0, 0xf1234567890abcdef
    li s1, 0x01234567890abcdef
    subd s2, s1, s0
    //prgchk reg s2 == 0

    // Substract two arbitrary 64-bit values (positive result).
    li s0, 0x1337d00dcafebabe
    li s1, 0x02bed49441921aad

    subd s2, s0, s1
    //prgchk reg s2 == 0x1078fb79896ca011

    // Subtract two arbitrary 128-bit values (negative result).
    subd s2, s1, s0
    //prgchk reg s2 == 0xffffffffffffffffef87048676935fef
    j exit
