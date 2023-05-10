#include "insns.S" 
#include "utils.S"

.section .rodata
    w1:     .word 0x87654321
    w2:     .word 0x12345678
    w3:     .word 0x42
    w4:     .word 0x78967451
    w5:     .word 0xffffffff
    w6:     .word 0xffffffd6
    minsgn: .word 0x80000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Various basic divisions
    lw t0, w1
    lw t1, w2
    divuw t2, t0, t1
    //prgchk reg t2 == 0x7

    divuw t2, t1, t0
    //prgchk reg t2 == 0

    lw t1, w3
    divuw t2, t0, t1
    //prgchk reg t2 == 0x20d2baf
    
    // Divide by self.
    divuw t2, t0, t0
    //prgchk reg t2 == 1

    // Divide by -1
    lw t0, w1
    lw t1, w5
    divuw t2, t0, t1
    //prgchk reg t2 == 0

    lw t0, w4
    divuw t2, t0, t1
    //prgchk reg t2 == 0

    lw t0, w6
    divuw t2, t0, t1
    //prgchk reg t2 == 0

    // Check div by zero behavior
    lw t0, w1
    liu(t1, 0
    divuw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff
    j exit
