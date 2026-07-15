#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial subtraction with overflow : 0 - 1
    li s0, 0
    li s1, 1

    sub s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // No effect subtraction : 0x1234567890abcdef - 0
    li s1, 0x1234567890abcdef

    sub s2, s1, s0
    //prgchk reg s2 == 0x1234567890abcdef

    // Destination to r0 : no effect
    sub zero, s1, s0
    //prgchk reg zero == 0

    // Subtract with self on 128 bits
    sub s3, s2, s2
    //prgchk reg s3 == 0

    // Substract two arbitrary 128-bit values (positive result).
    li s0, 0x1337d00dcafebabe1234567890abcdef
    li s1, 0x02bed49441921aad70509ea38261afb4

    sub s2, s0, s1
    //prgchk reg s2 == 0x1078fb79896ca010a1e3b7d50e4a1e3b

    // Subtract two arbitrary 128-bit values (negative result).
    sub s2, s1, s0
    //prgchk reg s2 == 0xef87048676935fef5e1c482af1b5e1c5
    j exit

