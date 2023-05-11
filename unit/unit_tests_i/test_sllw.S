#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check usage of only low 5 bits.
    li t0, 0xcafebabe
    li t1, 48 // should give a shift of 16
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffbabe0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Check incremental shifts from 0 to 31 on known value.
    li t0, 0xdeadbeef
    li t1, 0
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 1
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffbd5b7dde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 2
    sllw t2, t0, t1
    //prgchk reg t2 == 0x7ab6fbbc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 3
    sllw t2, t0, t1
    //prgchk reg t2 == 0xfffffffff56df778
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 4
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffeadbeef0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 5
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffd5b7dde0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 6
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffab6fbbc0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 7
    sllw t2, t0, t1
    //prgchk reg t2 == 0x56df7780
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 8
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffadbeef00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 9
    sllw t2, t0, t1
    //prgchk reg t2 == 0x5b7dde00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 10
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffb6fbbc00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 11
    sllw t2, t0, t1
    //prgchk reg t2 == 0x6df77800
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 12
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffdbeef000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 13
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffb7dde000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 14
    sllw t2, t0, t1
    //prgchk reg t2 == 0x6fbbc000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 15
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffdf778000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 16
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffbeef0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 17
    sllw t2, t0, t1
    //prgchk reg t2 == 0x7dde0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 18
    sllw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffbbc0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 19
    sllw t2, t0, t1
    //prgchk reg t2 == 0xfffffffff7780000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 20
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffeef00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 21
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffdde00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 22
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffbbc00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 23
    sllw t2, t0, t1
    //prgchk reg t2 == 0x77800000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 24
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffef000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 25
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffde000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 26
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffbc000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 27
    sllw t2, t0, t1
    //prgchk reg t2 == 0x78000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 28
    sllw t2, t0, t1
    //prgchk reg t2 == 0xfffffffff0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 29
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffe0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 30
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffffc0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 31
    sllw t2, t0, t1
    //prgchk reg t2 == 0xffffffff80000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    j exit
