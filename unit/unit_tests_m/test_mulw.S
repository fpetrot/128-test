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
    lw s0, w1
    lw s1, w2
    mulw s2, s0, s1
    //prgchk reg s2 == 0x70b88d78
    mulw s2, s1, s0
    //prgchk reg s2 == 0x70b88d78

    lw s0, w2
    lw s1, minusone
    mulw s2, s0, s1
    //prgchk reg s2 == 0x789abcdf

    lw s0, minusone
    lw s1, w3
    mulw s2, s0, s1
    //prgchk reg s2 == 42

    lw s0, minusone
    mulw s2, s0, s0
    //prgchk reg s2 == 1

    // test sign extension
    lw s0, w4
    liu(s1, 2)
    mulw s2, s0, s1
    //prgchk reg s2 == 0xffffffffe0000000
    mulw s2, s1, s0
    //prgchk reg s2 == 0xffffffffffffffffffffffffe0000000
    j exit
