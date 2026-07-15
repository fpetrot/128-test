#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0xffffffffffffffff
    //prgchk reg s0 == 0xffffffffffffffff

    // Check no data is lost by shifting left and then right again by 64 (double word shift).
    slli s0, s0, 64
    //prgchk reg s0 == 0xffffffffffffffff0000000000000000
    
    // Shifting all bits out through the right.
    srli s0, s0, 64
    //prgchk reg s0 == 0xffffffffffffffff

    li s0, 0xffffffffffffffff
    srli s0, s0, 32
    //prgchk reg s0 == 0xffffffff

    j exit
