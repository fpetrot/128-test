#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial subtraction with overflow : 0 - 1
    li t0, 0
    li t1, 1

    sub t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    // No effect subtraction : 0x1234567890abcdef - 0
    li t1, 0x1234567890abcdef

    sub t2, t1, t0
    //prgchk reg t2 == 0x1234567890abcdef

    // Destination to r0 : no effect
    sub zero, t1, t0
    //prgchk reg zero == 0

    // Subtract with self on 128 bits
    sub t3, t2, t2
    //prgchk reg t3 == 0

    // Substract two arbitrary 128-bit values (positive result).
    li t0, 0x1337d00dcafebabe1234567890abcdef
    li t1, 0x02bed49441921aad70509ea38261afb4

    sub t2, t0, t1
    //prgchk reg t2 == 0x1078fb79896ca010a1e3b7d50e4a1e3b

    // Subtract two arbitrary 128-bit values (negative result).
    sub t2, t1, t0
    //prgchk reg t2 == 0xef87048676935fef5e1c482af1b5e1c5
    j exit

