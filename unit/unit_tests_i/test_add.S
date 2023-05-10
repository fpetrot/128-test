#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial addition with overflow : -1 + 1
    liu(t0, 1)
    //prgchk reg t0 == 1
    slli t0, t0, 127
    srai t0, t0, 127
    //prgchk reg t0 == 0xffffffffffffffff

    liu(t1, 1)
    //prgchk reg t1 == 1

    add t2, t0, t1
    //prgchk reg t2 == 0

    // No effect addition with zero
    liu(t1, 0x1234567890abcdef)
    slli t1, t1, 64
    liu(t2, 0xdeadbeefcafebabe)    
    or t1, t1, t2

    add t2, t1, zero
    //prgchk reg t2 == 0x1234567890abcdefdeadbeefcafebabe

    // Destination to r0 : no effect
    add zero, t1, t0
    //prgchk reg zero == 0

    // Add two arbitrary 128-bit values.
    liu(t1, 0x1337d00dcafebabe)
    //prgchk reg t1 == 0x1337d00dcafebabe
    sllit0, t1, 64
    liu(t1, 0x1234567890abcdef)    
    or t0, t0, t1
    //prgchk reg t0 == 0x1337d00dcafebabe1234567890abcdef

    liu(t2, 0x2bed49441921aad)
    slli t1, t2, 64
    liu(t2, 0x70509ea38261afb4)   
    or t1, t1, t2

    add t2, t0, t1
    //prgchk reg t2 == 0x15f6a4a20c90d56b8284f51c130d7da3
    j exit
