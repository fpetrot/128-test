#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check sign extensions.
    li s0, 0x80000000
    srliw s1, s0, 0
    //prgchk reg s1 == 0xffffffffffffffffffffffff80000000


    li s0, 0x7fedfedf
    srliw s1, s0, 0
    //prgchk reg s1 == 0x7fedfedf


    li s0, 0x1234567800000000
    srliw s1, s0, 12
    //prgchk reg s1 == 0


    // Incremental shifts from 0 to 31.
    li s0, 0xdeadbeef
    srliw s2, s0, 0
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef

    srliw s2, s0, 1
    //prgchk reg s2 == 0x6f56df77

    srliw s2, s0, 2
    //prgchk reg s2 == 0x37ab6fbb

    srliw s2, s0, 3
    //prgchk reg s2 == 0x1bd5b7dd

    srliw s2, s0, 4
    //prgchk reg s2 == 0xdeadbee

    srliw s2, s0, 5
    //prgchk reg s2 == 0x6f56df7

    srliw s2, s0, 6
    //prgchk reg s2 == 0x37ab6fb

    srliw s2, s0, 7
    //prgchk reg s2 == 0x1bd5b7d

    srliw s2, s0, 8
    //prgchk reg s2 == 0xdeadbe

    srliw s2, s0, 9
    //prgchk reg s2 == 0x6f56df

    srliw s2, s0, 10
    //prgchk reg s2 == 0x37ab6f

    srliw s2, s0, 11
    //prgchk reg s2 == 0x1bd5b7

    srliw s2, s0, 12
    //prgchk reg s2 == 0xdeadb

    srliw s2, s0, 13
    //prgchk reg s2 == 0x6f56d

    srliw s2, s0, 14
    //prgchk reg s2 == 0x37ab6

    srliw s2, s0, 15
    //prgchk reg s2 == 0x1bd5b

    srliw s2, s0, 16
    //prgchk reg s2 == 0xdead

    srliw s2, s0, 17
    //prgchk reg s2 == 0x6f56

    srliw s2, s0, 18
    //prgchk reg s2 == 0x37ab

    srliw s2, s0, 19
    //prgchk reg s2 == 0x1bd5

    srliw s2, s0, 20
    //prgchk reg s2 == 0xdea

    srliw s2, s0, 21
    //prgchk reg s2 == 0x6f5

    srliw s2, s0, 22
    //prgchk reg s2 == 0x37a

    srliw s2, s0, 23
    //prgchk reg s2 == 0x1bd

    srliw s2, s0, 24
    //prgchk reg s2 == 0xde

    srliw s2, s0, 25
    //prgchk reg s2 == 0x6f

    srliw s2, s0, 26
    //prgchk reg s2 == 0x37

    srliw s2, s0, 27
    //prgchk reg s2 == 0x1b

    srliw s2, s0, 28
    //prgchk reg s2 == 0xd

    srliw s2, s0, 29
    //prgchk reg s2 == 0x6

    srliw s2, s0, 30
    //prgchk reg s2 == 0x3

    srliw s2, s0, 31
    //prgchk reg s2 == 0x1

    j exit
