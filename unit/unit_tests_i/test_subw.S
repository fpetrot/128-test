#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial subtraction with overflow : 0 - 1
    li s0, 0
    //prgchk reg s0 == 0

    li s1, 1
    //prgchk reg s1 == 1

    subw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // No effect subtraction : 0x12345678 - 0
    li s1, 0x12345678

    subw s2, s1, s0
    //prgchk reg s2 == 0x12345678

    // Destination to r0 : no effect
    subw zero, s1, s0
    //prgchk reg zero == 0

    // Subtract with self on 32 bits (with bits above 31 set)
    li s0, 0xdeadbeef8badf00d
    li s1, 0x0000babe8badf00d
    subw s2, s1, s0
    //prgchk reg s2 == 0

    // Substract two arbitrary 32-bit values (positive result).
    li s0, 0x1337d00d
    li s1, 0x099be806

    subw s2, s0, s1
    //prgchk reg s2 == 0x99be807

    // Subtract two arbitrary 32-bit values (negative result).
    subw s2, s1, s0
    //prgchk reg s2 == 0xfffffffffffffffffffffffff66417f9
    j exit
