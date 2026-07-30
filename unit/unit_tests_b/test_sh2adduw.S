#include "exit.S"
.section .data
    .align 4
    warray: .word 1, 2, 3, 5, 7, 11, 13, 17, 0xffff
.section .text.init,"ax",@progbits
.globl _start
_start:
    // Quick value checks
    // Check that a shift of 3 is carried out on the first operand
    li s0, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    li s1, 0
    sh2add.uw s0, s0, s1
    //prgchk reg s0 == 0x000000000000000000000003FFFFFFFC

    // Check that the second operand is added to the first
    li s0, 0
    li s1, 0xcafebabedeadbeefcafebeefdeadbabe
    sh2add.uw s0, s0, s1
    //prgchk reg s0 == 0xcafebabedeadbeefcafebeefdeadbabe

    // Check that the second operand is added to the first (overflow)
    li s0, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    li s1, 0b100
    sh2add.uw s0, s0, s1
    //prgchk reg s0 == 0x400000000

    # Load array address
    la s0, warray

    li s1, 0xdeadbeefdeadbeefdeadbeef00000000
    //prgchk reg s1 == 0xdeadbeefdeadbeefdeadbeef00000000

    addi s1, s1, 1
    sh2add.uw s2, s1, s0
    lwu s2, 0(s2)
    //prgchk reg s2 == 2

    add s1, s1, 1
    sh2add.uw s2, s1, s0
    lwu s2, 0(s2)
    //prgchk reg s2 == 3

    add s1, s1, 1
    sh2add.uw s2, s1, s0
    lwu s2, 0(s2)
    //prgchk reg s2 == 5

    add s1, s1, 1
    sh2add.uw s2, s1, s0
    lwu s2, 0(s2)
    //prgchk reg s2 == 7

    add s1, s1, 2
    sh2add.uw s2, s1, s0
    lwu s2, 0(s2)
    //prgchk reg s2 == 13

    j exit
