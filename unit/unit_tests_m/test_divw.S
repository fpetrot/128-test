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
    divw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffa

    divw t2, t1, t0
    //prgchk reg t2 == 0

    lw t1, w3
    divw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffe2c3371
    
    // Divide by self.
    divw t2, t0, t0
    //prgchk reg t2 == 1

    // Divide by -1
    lw t0, w1
    lw t1, w5
    divw t2, t0, t1
    //prgchk reg t2 == 0x789abcdf

    lw t0, w4
    divw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffff87698baf

    lw t0, w6
    divw t2, t0, t1
    //prgchk reg t2 == 42

    // Check overflow behavior.
    lw t0, minsgn
    lw t1, w5
    divw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffff80000000

    // Check div by zero behavior
    lw t0, w1
    liu(t1, 0)
    divw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff
    j exit
