#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Carry of zero sign bit
    li t0, 0x7fffffff
    li t1, 16
    sraw t2, t0, t1
    //prgchk reg t2 == 0x00007fff

    // Check usage of only low 5 bits.
    li t0, 0xcafebabe
    li t1, 48 // should give a shift of 16
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffcafe


    // Incremental shifts from 0 to 31 of known value.
    li t0, 0xdeadbeef
    li t1, 0
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef

    li t1, 1
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffef56df77

    li t1, 2
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffff7ab6fbb

    li t1, 3
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffbd5b7dd

    li t1, 4
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffdeadbee

    li t1, 5
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffef56df7

    li t1, 6
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffff7ab6fb

    li t1, 7
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffbd5b7d

    li t1, 8
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffdeadbe

    li t1, 9
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffef56df

    li t1, 10
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffff7ab6f

    li t1, 11
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffbd5b7

    li t1, 12
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffdeadb

    li t1, 13
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffef56d

    li t1, 14
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffff7ab6

    li t1, 15
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffbd5b

    li t1, 16
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffdead

    li t1, 17
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffef56

    li t1, 18
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffff7ab

    li t1, 19
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffbd5

    li t1, 20
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffdea

    li t1, 21
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffef5

    li t1, 22
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffff7a

    li t1, 23
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffbd

    li t1, 24
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffde

    li t1, 25
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffef

    li t1, 26
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffff7

    li t1, 27
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffb

    li t1, 28
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffd

    li t1, 29
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffe

    li t1, 30
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    li t1, 31
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    j exit
