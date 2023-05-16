#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check sign extensions.
    li t0, 0x80000000
    srliw t1, t0, 0
    //prgchk reg t1 == 0xffffffffffffffffffffffff80000000


    li t0, 0x7fedfedf
    srliw t1, t0, 0
    //prgchk reg t1 == 0x7fedfedf


    li t0, 0x1234567800000000
    srliw t1, t0, 12
    //prgchk reg t1 == 0


    // Incremental shifts from 0 to 31.
    li t0, 0xdeadbeef
    srliw t2, t0, 0
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef

    srliw t2, t0, 1
    //prgchk reg t2 == 0x6f56df77

    srliw t2, t0, 2
    //prgchk reg t2 == 0x37ab6fbb

    srliw t2, t0, 3
    //prgchk reg t2 == 0x1bd5b7dd

    srliw t2, t0, 4
    //prgchk reg t2 == 0xdeadbee

    srliw t2, t0, 5
    //prgchk reg t2 == 0x6f56df7

    srliw t2, t0, 6
    //prgchk reg t2 == 0x37ab6fb

    srliw t2, t0, 7
    //prgchk reg t2 == 0x1bd5b7d

    srliw t2, t0, 8
    //prgchk reg t2 == 0xdeadbe

    srliw t2, t0, 9
    //prgchk reg t2 == 0x6f56df

    srliw t2, t0, 10
    //prgchk reg t2 == 0x37ab6f

    srliw t2, t0, 11
    //prgchk reg t2 == 0x1bd5b7

    srliw t2, t0, 12
    //prgchk reg t2 == 0xdeadb

    srliw t2, t0, 13
    //prgchk reg t2 == 0x6f56d

    srliw t2, t0, 14
    //prgchk reg t2 == 0x37ab6

    srliw t2, t0, 15
    //prgchk reg t2 == 0x1bd5b

    srliw t2, t0, 16
    //prgchk reg t2 == 0xdead

    srliw t2, t0, 17
    //prgchk reg t2 == 0x6f56

    srliw t2, t0, 18
    //prgchk reg t2 == 0x37ab

    srliw t2, t0, 19
    //prgchk reg t2 == 0x1bd5

    srliw t2, t0, 20
    //prgchk reg t2 == 0xdea

    srliw t2, t0, 21
    //prgchk reg t2 == 0x6f5

    srliw t2, t0, 22
    //prgchk reg t2 == 0x37a

    srliw t2, t0, 23
    //prgchk reg t2 == 0x1bd

    srliw t2, t0, 24
    //prgchk reg t2 == 0xde

    srliw t2, t0, 25
    //prgchk reg t2 == 0x6f

    srliw t2, t0, 26
    //prgchk reg t2 == 0x37

    srliw t2, t0, 27
    //prgchk reg t2 == 0x1b

    srliw t2, t0, 28
    //prgchk reg t2 == 0xd

    srliw t2, t0, 29
    //prgchk reg t2 == 0x6

    srliw t2, t0, 30
    //prgchk reg t2 == 0x3

    srliw t2, t0, 31
    //prgchk reg t2 == 0x1

    j exit
