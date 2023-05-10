#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check usage of only low 5 bits.
    li t0, 0xcafebabe
    li t1, 48 // should give a shift of 16
    srlw t2, t0, t1
    //prgchk reg t2 == 0xcafe


    li t0, 0xdeadbeef
    li t1, 0
    srlw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef

    li t1, 1
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56df77

    li t1, 2
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbb

    li t1, 3
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7dd

    li t1, 4
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdeadbee

    li t1, 5
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56df7

    li t1, 6
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab6fb

    li t1, 7
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7d

    li t1, 8
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdeadbe

    li t1, 9
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56df

    li t1, 10
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab6f

    li t1, 11
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7

    li t1, 12
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdeadb

    li t1, 13
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56d

    li t1, 14
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab6

    li t1, 15
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5b

    li t1, 16
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdead

    li t1, 17
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56

    li t1, 18
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab

    li t1, 19
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5

    li t1, 20
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdea

    li t1, 21
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f5

    li t1, 22
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37a

    li t1, 23
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd

    li t1, 24
    srlw t2, t0, t1
    //prgchk reg t2 == 0xde

    li t1, 25
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f

    li t1, 26
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37

    li t1, 27
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1b

    li t1, 28
    srlw t2, t0, t1
    //prgchk reg t2 == 0xd

    li t1, 29
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6

    li t1, 30
    srlw t2, t0, t1
    //prgchk reg t2 == 0x3

    li t1, 31
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1

    j exit
