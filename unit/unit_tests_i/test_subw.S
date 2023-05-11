#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial subtraction with overflow : 0 - 1
    li t0, 0
    //prgchk reg t0 == 0

    li t1, 1
    //prgchk reg t1 == 1

    subw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t3, t2, 64)
    //prgchk reg t3 == 0xffffffffffffffff

    // No effect subtraction : 0x12345678 - 0
    liu(t1, 0x12345678)

    subw t2, t1, t0
    //prgchk reg t2 == 0x12345678
    srli(t3, t2, 64)
    //prgchk reg t3 == 0

    // Destination to r0 : no effect
    subw zero, t1, t0
    //prgchk reg zero == 0
    srli(t0, zero, 64)
    //prgchk reg t0 == 0

    // Subtract with self on 32 bits (with bits above 31 set)
    slli(t2, t2, 32)
    or t2, t2, t1
    subw t2, t2, t2
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Substract two arbitrary 32-bit values (positive result).
    li t0, 0x1337d00d
    li t1, 0x99be806

    subw t2, t0, t1
    //prgchk reg t2 == 0x99be807
    srli(t3, t2, 64)
    //prgchk reg t3 == 0

    // Subtract two arbitrary 32-bit values (negative result).
    subw t2, t1, t0
    //prgchk reg t2 == 0xfffffffff66417f9
    srli(t3, t2, 64)
    //prgchk reg t3 == 0xffffffffffffffff
    j exit
