#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check sign extensions.
    li s0, 0x8badf00d
    sraiw s1, s0, 0
    //prgchk reg s1 == 0xffffffffffffffffffffffff8badf00d

    li s0, 0x2badbabe
    sraiw s1, s0, 0
    //prgchk reg s1 == 0x2badbabe


    li s0, 0xf0000000d
    sraiw s1, s0, 12
    //prgchk reg s1 == 0

    // Incremental shifts from 0 to 31.
    li s0, 0xdeadbeef
    sraiw s2, s0, 0
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef

    sraiw s2, s0, 1
    //prgchk reg s2 == 0xffffffffffffffffffffffffef56df77

    sraiw s2, s0, 2
    //prgchk reg s2 == 0xfffffffffffffffffffffffff7ab6fbb

    sraiw s2, s0, 3
    //prgchk reg s2 == 0xfffffffffffffffffffffffffbd5b7dd

    sraiw s2, s0, 4
    //prgchk reg s2 == 0xfffffffffffffffffffffffffdeadbee

    sraiw s2, s0, 5
    //prgchk reg s2 == 0xfffffffffffffffffffffffffef56df7

    sraiw s2, s0, 6
    //prgchk reg s2 == 0xffffffffffffffffffffffffff7ab6fb

    sraiw s2, s0, 7
    //prgchk reg s2 == 0xffffffffffffffffffffffffffbd5b7d

    sraiw s2, s0, 8
    //prgchk reg s2 == 0xffffffffffffffffffffffffffdeadbe

    sraiw s2, s0, 9
    //prgchk reg s2 == 0xffffffffffffffffffffffffffef56df

    sraiw s2, s0, 10
    //prgchk reg s2 == 0xfffffffffffffffffffffffffff7ab6f

    sraiw s2, s0, 11
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffbd5b7

    sraiw s2, s0, 12
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffdeadb

    sraiw s2, s0, 13
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffef56d

    sraiw s2, s0, 14
    //prgchk reg s2 == 0xffffffffffffffffffffffffffff7ab6

    sraiw s2, s0, 15
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffbd5b

    sraiw s2, s0, 16
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffdead

    sraiw s2, s0, 17
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffef56

    sraiw s2, s0, 18
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffff7ab

    sraiw s2, s0, 19
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffbd5

    sraiw s2, s0, 20
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffdea

    sraiw s2, s0, 21
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffef5

    sraiw s2, s0, 22
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffff7a

    sraiw s2, s0, 23
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffbd

    sraiw s2, s0, 24
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffde

    sraiw s2, s0, 25
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffef

    sraiw s2, s0, 26
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffff7

    sraiw s2, s0, 27
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffb

    sraiw s2, s0, 28
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffd

    sraiw s2, s0, 29
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffe

    sraiw s2, s0, 30
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    sraiw s2, s0, 31
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    j exit
