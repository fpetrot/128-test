#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check sign extensions.
    liu(t0, 0x80000000)
    slliw t1, t0, 0
    //prgchk reg t1 == 0xffffffff80000000
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    liu(t0, 0x7fedfedf)
    slliw t1, t0, 0
    //prgchk reg t1 == 0x7fedfedf
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    slliw t1, t0, 1
    //prgchk reg t1 == 0xffffffffffdbfdbe
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    // Incremental shifts from 0 to 31
    li t0, 0xdeadbeef
    slliw t2, t0, 0
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 1
    //prgchk reg t2 == 0xffffffffbd5b7dde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 2
    //prgchk reg t2 == 0x7ab6fbbc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    slliw t2, t0, 3
    //prgchk reg t2 == 0xfffffffff56df778
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 4
    //prgchk reg t2 == 0xffffffffeadbeef0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 5
    //prgchk reg t2 == 0xffffffffd5b7dde0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 6
    //prgchk reg t2 == 0xffffffffab6fbbc0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 7
    //prgchk reg t2 == 0x56df7780
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    slliw t2, t0, 8
    //prgchk reg t2 == 0xffffffffadbeef00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 9
    //prgchk reg t2 == 0x5b7dde00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    slliw t2, t0, 10
    //prgchk reg t2 == 0xffffffffb6fbbc00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 11
    //prgchk reg t2 == 0x6df77800
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    slliw t2, t0, 12
    //prgchk reg t2 == 0xffffffffdbeef000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 13
    //prgchk reg t2 == 0xffffffffb7dde000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 14
    //prgchk reg t2 == 0x6fbbc000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    slliw t2, t0, 15
    //prgchk reg t2 == 0xffffffffdf778000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 16
    //prgchk reg t2 == 0xffffffffbeef0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 17
    //prgchk reg t2 == 0x7dde0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    slliw t2, t0, 18
    //prgchk reg t2 == 0xfffffffffbbc0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 19
    //prgchk reg t2 == 0xfffffffff7780000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 20
    //prgchk reg t2 == 0xffffffffeef00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 21
    //prgchk reg t2 == 0xffffffffdde00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 22
    //prgchk reg t2 == 0xffffffffbbc00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 23
    //prgchk reg t2 == 0x77800000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    slliw t2, t0, 24
    //prgchk reg t2 == 0xffffffffef000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 25
    //prgchk reg t2 == 0xffffffffde000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 26
    //prgchk reg t2 == 0xffffffffbc000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 27
    //prgchk reg t2 == 0x78000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    slliw t2, t0, 28
    //prgchk reg t2 == 0xfffffffff0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 29
    //prgchk reg t2 == 0xffffffffe0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 30
    //prgchk reg t2 == 0xffffffffc0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    slliw t2, t0, 31
    //prgchk reg t2 == 0xffffffff80000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    j exit
