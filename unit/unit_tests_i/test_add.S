#include "exit.S"
.section .text.init,"ax",@progbits
.globl _start
.align 8
_start:
    // Trivial addition with overflow : -1 + 1
    li s0, 1
    //prgchk reg s0 == 1
    slli s0, s0, 127
    //prgchk reg s0 == 0x80000000000000000000000000000000
    srai s0, s0, 127
    //prgchk reg s0 == 0xffffffffffffffffffffffffffffffff

    li s1, 1
    //prgchk reg s1 == 1

    add s2, s0, s1
    //prgchk reg s2 == 0

    // No effect addition with zero
    li s1, 0x1234567890abcdefdeadbeefcafebabe
    add s2, s1, zero
    //prgchk reg s2 == 0x1234567890abcdefdeadbeefcafebabe

    // Destination to r0 : no effect
    add zero, s1, s0
    //prgchk reg zero == 0

    // Add two arbitrary 128-bit values.
    li s0, 0x1337d00dcafebabe1234567890abcdef
    li s1, 0x2bed49441921aad70509ea38261afb4
    add s2, s0, s1
    //prgchk reg s2 == 0x15f6a4a20c90d56b8284f51c130d7da3
    j exit
