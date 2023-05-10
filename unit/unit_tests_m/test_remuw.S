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
    remuw t2, t0, t1
    //prgchk reg t2 == 0x7f6e5d9

    remuw t2, t1, t0
    //prgchk reg t2 == 0x12345678

    lw t1, w3
    remuw t2, t0, t1
    //prgchk reg t2 == 3
    
    // Divide by self.
    remuw t2, t0, t0
    //prgchk reg t2 == 0

    // Divide by -1
    lw t0, w1
    lw t1, w5
    remuw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffff87654321

    lw t0, w4
    remuw t2, t0, t1
    //prgchk reg t2 == 0x78967451

    lw t0, w6
    remuw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffd6

    // Check div by zero behavior
    lw t0, w1
    liu t1, 0
    remuw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffff87654321
    j exit
