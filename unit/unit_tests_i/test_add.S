#include "insns.S"
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    ##  Trivial addition with overflow : -1 + 1
    li t0, 1
    slli t0, t0, 64
    srli t0, t0, 64
    //prgchk reg t0 == 1
    slli t0, t0, 127
    srai t0, t0, 127
    //prgchk reg t0 == 0xffffffffffffffffffffffffffffffff

    li t1, 1
    //prgchk reg t1 == 1

    add t2, t0, t1
    //prgchk reg t2 == 0

    ##  No effect addition with zero
    li t1, 0x1234567890abcdef
    slli t1, t1, 64
    li t2, 0xdeadbeefcafebabe
    or t1, t1, t2

    add t2, t1, zero
    //prgchk reg t2 == 0x1234567890abcdefdeadbeefcafebabe

    ##  Destination to r0 : no effect
    add zero, t1, t0
    //prgchk reg zero == 0
    srli t0, zero, 64
    //prgchk reg t0 == 0

    ##  Add two arbitrary 128-bit values.
    li t0, 0x1337d00dcafebabe1234567890abcdef
    //prgchk reg t0 == 0x1337d00dcafebabe1234567890abcdef

    li t1, 0x2bed49441921aad70509ea38261afb4


    add t2, t0, t1
    //prgchk reg t2 == 0x15f6a4a20c90d56b8284f51c130d7da3
    j exit
