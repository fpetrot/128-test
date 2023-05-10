#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check sign extensions.
    liu t0, 0x80000000
    slliw t1, t0, 0
    //prgchk reg t1 == 0xffffffffffffffffffffffff80000000

    liu t0, 0x7fedfedf
    slliw t1, t0, 0
    //prgchk reg t1 == 0x7fedfedf
    

    slliw t1, t0, 1
    //prgchk reg t1 == 0xffffffffffffffffffffffffffdbfdbe

    // Incremental shifts from 0 to 31
    li t0, 0xdeadbeef
    slliw t2, t0, 0
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef

    slliw t2, t0, 1
    //prgchk reg t2 == 0xffffffffffffffffffffffffbd5b7dde

    slliw t2, t0, 2
    //prgchk reg t2 == 0x0000000000000000000000007ab6fbbc

    slliw t2, t0, 3
    //prgchk reg t2 == 0xfffffffffffffffffffffffff56df778

    slliw t2, t0, 4
    //prgchk reg t2 == 0xffffffffffffffffffffffffeadbeef0

    slliw t2, t0, 5
    //prgchk reg t2 == 0xffffffffffffffffffffffffd5b7dde0

    slliw t2, t0, 6
    //prgchk reg t2 == 0xffffffffffffffffffffffffab6fbbc0

    slliw t2, t0, 7
    //prgchk reg t2 == 0x00000000000000000000000056df7780

    slliw t2, t0, 8
    //prgchk reg t2 == 0xffffffffffffffffffffffffadbeef00

    slliw t2, t0, 9
    //prgchk reg t2 == 0x0000000000000000000000005b7dde00

    slliw t2, t0, 10
    //prgchk reg t2 == 0xffffffffffffffffffffffffb6fbbc00

    slliw t2, t0, 11
    //prgchk reg t2 == 0x0000000000000000000000006df77800

    slliw t2, t0, 12
    //prgchk reg t2 == 0xffffffffffffffffffffffffdbeef000

    slliw t2, t0, 13
    //prgchk reg t2 == 0xffffffffffffffffffffffffb7dde000

    slliw t2, t0, 14
    //prgchk reg t2 == 0x0000000000000000000000006fbbc000

    slliw t2, t0, 15
    //prgchk reg t2 == 0xffffffffffffffffffffffffdf778000

    slliw t2, t0, 16
    //prgchk reg t2 == 0xffffffffffffffffffffffffbeef0000

    slliw t2, t0, 17
    //prgchk reg t2 == 0x0000000000000000000000007dde0000

    slliw t2, t0, 18
    //prgchk reg t2 == 0xfffffffffffffffffffffffffbbc0000

    slliw t2, t0, 19
    //prgchk reg t2 == 0xfffffffffffffffffffffffff7780000

    slliw t2, t0, 20
    //prgchk reg t2 == 0xffffffffffffffffffffffffeef00000

    slliw t2, t0, 21
    //prgchk reg t2 == 0xffffffffffffffffffffffffdde00000

    slliw t2, t0, 22
    //prgchk reg t2 == 0xffffffffffffffffffffffffbbc00000

    slliw t2, t0, 23
    //prgchk reg t2 == 0x00000000000000000000000077800000

    slliw t2, t0, 24
    //prgchk reg t2 == 0xffffffffffffffffffffffffef000000

    slliw t2, t0, 25
    //prgchk reg t2 == 0xffffffffffffffffffffffffde000000

    slliw t2, t0, 26
    //prgchk reg t2 == 0xffffffffffffffffffffffffbc000000

    slliw t2, t0, 27
    //prgchk reg t2 == 0x00000000000000000000000078000000

    slliw t2, t0, 28
    //prgchk reg t2 == 0xfffffffffffffffffffffffff0000000

    slliw t2, t0, 29
    //prgchk reg t2 == 0xffffffffffffffffffffffffe0000000

    slliw t2, t0, 30
    //prgchk reg t2 == 0xffffffffffffffffffffffffc0000000

    slliw t2, t0, 31
    //prgchk reg t2 == 0xffffffffffffffffffffffff80000000

    j exit
