#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check usage of only low 5 bits.
    li s0, 0xcafebabe
    li s1, 48 // should give a shift of 16
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffbabe0000


    // Check incremental shifts from 0 to 31 on known value.
    li s0, 0xdeadbeef
    li s1, 0
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef

    li s1, 1
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffbd5b7dde

    li s1, 2
    sllw s2, s0, s1
    //prgchk reg s2 == 0x7ab6fbbc

    li s1, 3
    sllw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffff56df778

    li s1, 4
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffeadbeef0

    li s1, 5
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffd5b7dde0

    li s1, 6
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffab6fbbc0

    li s1, 7
    sllw s2, s0, s1
    //prgchk reg s2 == 0x56df7780

    li s1, 8
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffadbeef00

    li s1, 9
    sllw s2, s0, s1
    //prgchk reg s2 == 0x5b7dde00

    li s1, 10
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffb6fbbc00

    li s1, 11
    sllw s2, s0, s1
    //prgchk reg s2 == 0x6df77800

    li s1, 12
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdbeef000

    li s1, 13
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffb7dde000

    li s1, 14
    sllw s2, s0, s1
    //prgchk reg s2 == 0x6fbbc000

    li s1, 15
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdf778000

    li s1, 16
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffbeef0000

    li s1, 17
    sllw s2, s0, s1
    //prgchk reg s2 == 0x7dde0000

    li s1, 18
    sllw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffbbc0000

    li s1, 19
    sllw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffff7780000

    li s1, 20
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffeef00000

    li s1, 21
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdde00000

    li s1, 22
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffbbc00000

    li s1, 23
    sllw s2, s0, s1
    //prgchk reg s2 == 0x77800000

    li s1, 24
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffef000000

    li s1, 25
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffde000000

    li s1, 26
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffbc000000

    li s1, 27
    sllw s2, s0, s1
    //prgchk reg s2 == 0x78000000

    li s1, 28
    sllw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffff0000000

    li s1, 29
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffe0000000

    li s1, 30
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffc0000000

    li s1, 31
    sllw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffff80000000

    j exit
