#include "exit.S"
.section .data
    dwarray: .dword 1, 2, 3, 5, 7, 11, 13, 17, 0xffff
.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0xdeadbeefdeadbeef0000000000000000
    //prgchk reg t0 == 0xdeadbeefdeadbeef0000000000000000
    la a0, dwarray
    add t0, t0, 1
    sh1add.ud s0, a0, t0
    lh t1, (s0)
    //prgchk reg t1 == 2
    add t0, t0, 1
    sh1add.ud s0, a0, t0
    lh t1, (s0)
    //prgchk reg t1 == 3
    add t0, t0, 1
    sh1add.ud s0, a0, t0
    lh t1, (s0)
    //prgchk reg t1 == 5
    add t0, t0, 1
    sh1add.ud s0, a0, t0
    lh t1, (s0)
    //prgchk reg t1 == 7
    add t0, t0, 2
    sh1add.ud s0, a0, t0
    lh t1, (s0)
    //prgchk reg t1 == 13
    j exit
