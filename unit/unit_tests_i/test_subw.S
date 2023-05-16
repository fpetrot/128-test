#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial subtraction with overflow : 0 - 1
    li t0, 0
    //prgchk reg t0 == 0

    li t1, 1
    //prgchk reg t1 == 1

    subw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    // No effect subtraction : 0x12345678 - 0
    li t1, 0x12345678

    subw t2, t1, t0
    //prgchk reg t2 == 0x12345678

    // Destination to r0 : no effect
    subw zero, t1, t0
    //prgchk reg zero == 0

    // Subtract with self on 32 bits (with bits above 31 set)
    li t0, 0xdeadbeef8badf00d
    li t1, 0x0000babe8badf00d
    subw t2, t1, t0
    //prgchk reg t2 == 0

    // Substract two arbitrary 32-bit values (positive result).
    li t0, 0x1337d00d
    li t1, 0x099be806

    subw t2, t0, t1
    //prgchk reg t2 == 0x99be807

    // Subtract two arbitrary 32-bit values (negative result).
    subw t2, t1, t0
    //prgchk reg t2 == 0xfffffffffffffffffffffffff66417f9
    j exit
