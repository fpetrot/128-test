#include "insns.S" 
#include "utils.S"

.section .rodata
    w1:        .word 0x12345678
    w2:        .word 0x87654321
    minusone:  .word 0xffffffff
    w3:        .word 0xffffffd6
    w4:        .word 0x70000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    lw t0, w1
    lw t1, w2
    mulw t2, t0, t1
    //prgchk reg t2 == 0x70b88d78
    mulw t2, t1, t0
    //prgchk reg t2 == 0x70b88d78

    lw t0, w2
    lw t1, minusone
    mulw t2, t0, t1
    //prgchk reg t2 == 0x789abcdf

    lw t0, minusone
    lw t1, w3
    mulw t2, t0, t1
    //prgchk reg t2 == 42

    lw t0, minusone
    mulw t2, t0, t0
    //prgchk reg t2 == 1

    // test sign extension
    lw t0, w4
    liu t1, 2
    mulw t2, t0, t1
    //prgchk reg t2 == 0xffffffffe0000000
    mulw t2, t1, t0
    //prgchk reg t2 == 0xffffffffffffffffffffffffe0000000
    j exit
