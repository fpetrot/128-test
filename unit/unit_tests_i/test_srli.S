#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0xffffffffffffffff
    //prgchk reg t0 == 0xffffffffffffffff

    // Check no data is lost by shifting left and then right again by 64 (double word shift).
    slli t0, t0, 64
    //prgchk reg t0 == 0xffffffffffffffff0000000000000000
    
    // Shifting all bits out through the right.
    srli t0, t0, 64
    //prgchk reg t0 == 0xffffffffffffffff

    li t0, 0xffffffffffffffff
    srli t0, t0, 32
    //prgchk reg t0 == 0xffffffff

    j exit
