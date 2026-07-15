#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check sign extensions.
    li s0, 0x80000000
    slliw s1, s0, 0
    //prgchk reg s1 == 0xffffffffffffffffffffffff80000000

    li s0, 0x7fedfedf
    slliw s1, s0, 0
    //prgchk reg s1 == 0x7fedfedf
    

    slliw s1, s0, 1
    //prgchk reg s1 == 0xffffffffffffffffffffffffffdbfdbe

    // Incremental shifts from 0 to 31
    li s0, 0xdeadbeef
    slliw s2, s0, 0
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef

    slliw s2, s0, 1
    //prgchk reg s2 == 0xffffffffffffffffffffffffbd5b7dde

    slliw s2, s0, 2
    //prgchk reg s2 == 0x0000000000000000000000007ab6fbbc

    slliw s2, s0, 3
    //prgchk reg s2 == 0xfffffffffffffffffffffffff56df778

    slliw s2, s0, 4
    //prgchk reg s2 == 0xffffffffffffffffffffffffeadbeef0

    slliw s2, s0, 5
    //prgchk reg s2 == 0xffffffffffffffffffffffffd5b7dde0

    slliw s2, s0, 6
    //prgchk reg s2 == 0xffffffffffffffffffffffffab6fbbc0

    slliw s2, s0, 7
    //prgchk reg s2 == 0x00000000000000000000000056df7780

    slliw s2, s0, 8
    //prgchk reg s2 == 0xffffffffffffffffffffffffadbeef00

    slliw s2, s0, 9
    //prgchk reg s2 == 0x0000000000000000000000005b7dde00

    slliw s2, s0, 10
    //prgchk reg s2 == 0xffffffffffffffffffffffffb6fbbc00

    slliw s2, s0, 11
    //prgchk reg s2 == 0x0000000000000000000000006df77800

    slliw s2, s0, 12
    //prgchk reg s2 == 0xffffffffffffffffffffffffdbeef000

    slliw s2, s0, 13
    //prgchk reg s2 == 0xffffffffffffffffffffffffb7dde000

    slliw s2, s0, 14
    //prgchk reg s2 == 0x0000000000000000000000006fbbc000

    slliw s2, s0, 15
    //prgchk reg s2 == 0xffffffffffffffffffffffffdf778000

    slliw s2, s0, 16
    //prgchk reg s2 == 0xffffffffffffffffffffffffbeef0000

    slliw s2, s0, 17
    //prgchk reg s2 == 0x0000000000000000000000007dde0000

    slliw s2, s0, 18
    //prgchk reg s2 == 0xfffffffffffffffffffffffffbbc0000

    slliw s2, s0, 19
    //prgchk reg s2 == 0xfffffffffffffffffffffffff7780000

    slliw s2, s0, 20
    //prgchk reg s2 == 0xffffffffffffffffffffffffeef00000

    slliw s2, s0, 21
    //prgchk reg s2 == 0xffffffffffffffffffffffffdde00000

    slliw s2, s0, 22
    //prgchk reg s2 == 0xffffffffffffffffffffffffbbc00000

    slliw s2, s0, 23
    //prgchk reg s2 == 0x00000000000000000000000077800000

    slliw s2, s0, 24
    //prgchk reg s2 == 0xffffffffffffffffffffffffef000000

    slliw s2, s0, 25
    //prgchk reg s2 == 0xffffffffffffffffffffffffde000000

    slliw s2, s0, 26
    //prgchk reg s2 == 0xffffffffffffffffffffffffbc000000

    slliw s2, s0, 27
    //prgchk reg s2 == 0x00000000000000000000000078000000

    slliw s2, s0, 28
    //prgchk reg s2 == 0xfffffffffffffffffffffffff0000000

    slliw s2, s0, 29
    //prgchk reg s2 == 0xffffffffffffffffffffffffe0000000

    slliw s2, s0, 30
    //prgchk reg s2 == 0xffffffffffffffffffffffffc0000000

    slliw s2, s0, 31
    //prgchk reg s2 == 0xffffffffffffffffffffffff80000000

    j exit
