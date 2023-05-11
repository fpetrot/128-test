#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    liu(t0, 0xffffffffffffffff)
    //prgchk reg t0 == 0xffffffffffffffff

    // Check no data is lost by shifting left and then right again by 64 (double word shift).
    slli(t0, t0, 64)
    //prgchk reg t0 == 0
    srli(t0, t0, 64)
    //prgchk reg t0 == 0xffffffffffffffff
    
    // Shifting all bits out through the right.
    srli(t0, t0, 64)
    //prgchk reg t0 == 0

    liu(t0, 0xffffffffffffffff)
    //prgchk reg t0 == 0xffffffffffffffff
    srli(t0, t0, 32)
    //prgchk reg t0 == 0xffffffff
    j exit
