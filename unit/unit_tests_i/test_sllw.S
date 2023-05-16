#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check usage of only low 5 bits.
    li t0, 0xcafebabe
    li t1, 48 // should give a shift of 16
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffbabe0000


    // Check incremental shifts from 0 to 31 on known value.
    li t0, 0xdeadbeef
    li t1, 0
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef

    li t1, 1
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffbd5b7dde

    li t1, 2
    sllw t2, t0, t1
    //prgchk reg t2 == 0x7ab6fbbc

    li t1, 3
    sllw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffff56df778

    li t1, 4
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffeadbeef0

    li t1, 5
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffd5b7dde0

    li t1, 6
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffab6fbbc0

    li t1, 7
    sllw t2, t0, t1
    //prgchk reg t2 == 0x56df7780

    li t1, 8
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffadbeef00

    li t1, 9
    sllw t2, t0, t1
    //prgchk reg t2 == 0x5b7dde00

    li t1, 10
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffb6fbbc00

    li t1, 11
    sllw t2, t0, t1
    //prgchk reg t2 == 0x6df77800

    li t1, 12
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdbeef000

    li t1, 13
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffb7dde000

    li t1, 14
    sllw t2, t0, t1
    //prgchk reg t2 == 0x6fbbc000

    li t1, 15
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdf778000

    li t1, 16
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffbeef0000

    li t1, 17
    sllw t2, t0, t1
    //prgchk reg t2 == 0x7dde0000

    li t1, 18
    sllw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffbbc0000

    li t1, 19
    sllw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffff7780000

    li t1, 20
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffeef00000

    li t1, 21
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdde00000

    li t1, 22
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffbbc00000

    li t1, 23
    sllw t2, t0, t1
    //prgchk reg t2 == 0x77800000

    li t1, 24
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffef000000

    li t1, 25
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffde000000

    li t1, 26
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffbc000000

    li t1, 27
    sllw t2, t0, t1
    //prgchk reg t2 == 0x78000000

    li t1, 28
    sllw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffff0000000

    li t1, 29
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffe0000000

    li t1, 30
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffc0000000

    li t1, 31
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffff80000000

    j exit
