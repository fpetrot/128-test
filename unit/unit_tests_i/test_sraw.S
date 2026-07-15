#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Carry of zero sign bit
    li s0, 0x7fffffff
    li s1, 16
    sraw s2, s0, s1
    //prgchk reg s2 == 0x00007fff

    // Check usage of only low 5 bits.
    li s0, 0xcafebabe
    li s1, 48 // should give a shift of 16
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffcafe


    // Incremental shifts from 0 to 31 of known value.
    li s0, 0xdeadbeef
    li s1, 0
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef

    li s1, 1
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffef56df77

    li s1, 2
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffff7ab6fbb

    li s1, 3
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffbd5b7dd

    li s1, 4
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffdeadbee

    li s1, 5
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffef56df7

    li s1, 6
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffff7ab6fb

    li s1, 7
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffbd5b7d

    li s1, 8
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffdeadbe

    li s1, 9
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffef56df

    li s1, 10
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffff7ab6f

    li s1, 11
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffbd5b7

    li s1, 12
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffdeadb

    li s1, 13
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffef56d

    li s1, 14
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffff7ab6

    li s1, 15
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffbd5b

    li s1, 16
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffdead

    li s1, 17
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffef56

    li s1, 18
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffff7ab

    li s1, 19
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffbd5

    li s1, 20
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffdea

    li s1, 21
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffef5

    li s1, 22
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffff7a

    li s1, 23
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffbd

    li s1, 24
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffde

    li s1, 25
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffef

    li s1, 26
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffff7

    li s1, 27
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffb

    li s1, 28
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffd

    li s1, 29
    sraw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffe

    li s1, 30
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    li s1, 31
    sraw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    j exit
