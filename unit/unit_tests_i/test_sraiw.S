#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check sign extensions.
    li t0, 0x8badf00d
    sraiw t1, t0, 0
    //prgchk reg t1 == 0xffffffffffffffffffffffff8badf00d

    li t0, 0x2badbabe
    sraiw t1, t0, 0
    //prgchk reg t1 == 0x2badbabe


    li t0, 0xf0000000d
    sraiw t1, t0, 12
    //prgchk reg t1 == 0

    // Incremental shifts from 0 to 31.
    li t0, 0xdeadbeef
    sraiw t2, t0, 0
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef

    sraiw t2, t0, 1
    //prgchk reg t2 == 0xffffffffffffffffffffffffef56df77

    sraiw t2, t0, 2
    //prgchk reg t2 == 0xfffffffffffffffffffffffff7ab6fbb

    sraiw t2, t0, 3
    //prgchk reg t2 == 0xfffffffffffffffffffffffffbd5b7dd

    sraiw t2, t0, 4
    //prgchk reg t2 == 0xfffffffffffffffffffffffffdeadbee

    sraiw t2, t0, 5
    //prgchk reg t2 == 0xfffffffffffffffffffffffffef56df7

    sraiw t2, t0, 6
    //prgchk reg t2 == 0xffffffffffffffffffffffffff7ab6fb

    sraiw t2, t0, 7
    //prgchk reg t2 == 0xffffffffffffffffffffffffffbd5b7d

    sraiw t2, t0, 8
    //prgchk reg t2 == 0xffffffffffffffffffffffffffdeadbe

    sraiw t2, t0, 9
    //prgchk reg t2 == 0xffffffffffffffffffffffffffef56df

    sraiw t2, t0, 10
    //prgchk reg t2 == 0xfffffffffffffffffffffffffff7ab6f

    sraiw t2, t0, 11
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffbd5b7

    sraiw t2, t0, 12
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffdeadb

    sraiw t2, t0, 13
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffef56d

    sraiw t2, t0, 14
    //prgchk reg t2 == 0xffffffffffffffffffffffffffff7ab6

    sraiw t2, t0, 15
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffbd5b

    sraiw t2, t0, 16
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffdead

    sraiw t2, t0, 17
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffef56

    sraiw t2, t0, 18
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffff7ab

    sraiw t2, t0, 19
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffbd5

    sraiw t2, t0, 20
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffdea

    sraiw t2, t0, 21
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffef5

    sraiw t2, t0, 22
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffff7a

    sraiw t2, t0, 23
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffbd

    sraiw t2, t0, 24
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffde

    sraiw t2, t0, 25
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffef

    sraiw t2, t0, 26
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffff7

    sraiw t2, t0, 27
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffb

    sraiw t2, t0, 28
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffd

    sraiw t2, t0, 29
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffe

    sraiw t2, t0, 30
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    sraiw t2, t0, 31
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    j exit
