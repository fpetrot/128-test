#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial subtraction with overflow : 0 - 1
    li t0, 0
    //prgchk reg t0 == 0
    srli(t1, t0, 64)
    //prgchk reg t1 == 0

    li t1, 1
    //prgchk reg t1 == 1
    srli(t2, t1, 64)
    //prgchk reg t2 == 0

    sub t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t3, t2, 64)
    //prgchk reg t3 == 0xffffffffffffffff

    // No effect subtraction : 0x1234567890abcdef - 0
    liu(t1, 0x1234567890abcdef)

    sub t2, t1, t0
    //prgchk reg t2 == 0x1234567890abcdef
    srli(t3, t2, 64)
    //prgchk reg t3 == 0

    // Destination to r0 : no effect
    sub zero, t1, t0
    //prgchk reg zero == 0
    srli(t0, zero, 64)
    //prgchk reg t0 == 0

    // Subtract with self on 128 bits
    slli(t2, t1, 64)
    or t2, t2, t1
    sub t3, t2, t2
    //prgchk reg t3 == 0
    srli(t4, t3, 64)
    //prgchk reg t4 == 0

    // Substract two arbitrary 128-bit values (positive result).
    liu(t1, 0x1337d00dcafebabe)
    //prgchk reg t1 == 0x1337d00dcafebabe
    slli(t0, t1, 64)
    liu(t1, 0x1234567890abcdef)
    //prgchk reg t1 == 0x1234567890abcdef
    or t0, t0, t1
    //prgchk reg t1 == 0x1234567890abcdef

    liu(t2, 0x2bed49441921aad)
    slli(t1, t2, 64)
    liu(t2, 0x70509ea38261afb4)
    or t1, t1, t2

    sub t2, t0, t1
    //prgchk reg t2 == 0xa1e3b7d50e4a1e3b
    srli(t3, t2, 64)
    //prgchk reg t3 == 0x1078fb79896ca010

    // Subtract two arbitrary 128-bit values (negative result).
    sub t2, t1, t0
    //prgchk reg t2 == 0x5e1c482af1b5e1c5
    srli(t3, t2, 64)
    //prgchk reg t3 == 0xef87048676935fef
    j exit
