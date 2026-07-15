#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check usage of only low 5 bits.
    li s0, 0xcafebabe
    li s1, 48 // should give a shift of 16
    srlw s2, s0, s1
    //prgchk reg s2 == 0xcafe


    li s0, 0xdeadbeef
    li s1, 0
    srlw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef

    li s1, 1
    srlw s2, s0, s1
    //prgchk reg s2 == 0x6f56df77

    li s1, 2
    srlw s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbb

    li s1, 3
    srlw s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7dd

    li s1, 4
    srlw s2, s0, s1
    //prgchk reg s2 == 0xdeadbee

    li s1, 5
    srlw s2, s0, s1
    //prgchk reg s2 == 0x6f56df7

    li s1, 6
    srlw s2, s0, s1
    //prgchk reg s2 == 0x37ab6fb

    li s1, 7
    srlw s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7d

    li s1, 8
    srlw s2, s0, s1
    //prgchk reg s2 == 0xdeadbe

    li s1, 9
    srlw s2, s0, s1
    //prgchk reg s2 == 0x6f56df

    li s1, 10
    srlw s2, s0, s1
    //prgchk reg s2 == 0x37ab6f

    li s1, 11
    srlw s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7

    li s1, 12
    srlw s2, s0, s1
    //prgchk reg s2 == 0xdeadb

    li s1, 13
    srlw s2, s0, s1
    //prgchk reg s2 == 0x6f56d

    li s1, 14
    srlw s2, s0, s1
    //prgchk reg s2 == 0x37ab6

    li s1, 15
    srlw s2, s0, s1
    //prgchk reg s2 == 0x1bd5b

    li s1, 16
    srlw s2, s0, s1
    //prgchk reg s2 == 0xdead

    li s1, 17
    srlw s2, s0, s1
    //prgchk reg s2 == 0x6f56

    li s1, 18
    srlw s2, s0, s1
    //prgchk reg s2 == 0x37ab

    li s1, 19
    srlw s2, s0, s1
    //prgchk reg s2 == 0x1bd5

    li s1, 20
    srlw s2, s0, s1
    //prgchk reg s2 == 0xdea

    li s1, 21
    srlw s2, s0, s1
    //prgchk reg s2 == 0x6f5

    li s1, 22
    srlw s2, s0, s1
    //prgchk reg s2 == 0x37a

    li s1, 23
    srlw s2, s0, s1
    //prgchk reg s2 == 0x1bd

    li s1, 24
    srlw s2, s0, s1
    //prgchk reg s2 == 0xde

    li s1, 25
    srlw s2, s0, s1
    //prgchk reg s2 == 0x6f

    li s1, 26
    srlw s2, s0, s1
    //prgchk reg s2 == 0x37

    li s1, 27
    srlw s2, s0, s1
    //prgchk reg s2 == 0x1b

    li s1, 28
    srlw s2, s0, s1
    //prgchk reg s2 == 0xd

    li s1, 29
    srlw s2, s0, s1
    //prgchk reg s2 == 0x6

    li s1, 30
    srlw s2, s0, s1
    //prgchk reg s2 == 0x3

    li s1, 31
    srlw s2, s0, s1
    //prgchk reg s2 == 0x1

    j exit
