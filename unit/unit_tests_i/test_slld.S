#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check only first 6 bits are used for shift.
    li t0, 0xdeadbeefcafebabe
    li t1, 96 // will correspond to a shift of 32
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xcafebabe00000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Check incremental shifts from 0 to 63.
    li t0, 0xdeadbeefcafebabe
    li t1, 0
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefcafebabe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 1
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xbd5b7ddf95fd757c
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 2
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x7ab6fbbf2bfaeaf8
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 3
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xf56df77e57f5d5f0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 4
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xeadbeefcafebabe0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 5
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xd5b7ddf95fd757c0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 6
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xab6fbbf2bfaeaf80
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 7
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x56df77e57f5d5f00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 8
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xadbeefcafebabe00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 9
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x5b7ddf95fd757c00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 10
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xb6fbbf2bfaeaf800
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 11
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x6df77e57f5d5f000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 12
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xdbeefcafebabe000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 13
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xb7ddf95fd757c000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 14
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x6fbbf2bfaeaf8000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 15
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xdf77e57f5d5f0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 16
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xbeefcafebabe0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 17
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x7ddf95fd757c0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 18
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xfbbf2bfaeaf80000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 19
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xf77e57f5d5f00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 20
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xeefcafebabe00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 21
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xddf95fd757c00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 22
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xbbf2bfaeaf800000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 23
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x77e57f5d5f000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 24
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xefcafebabe000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 25
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xdf95fd757c000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 26
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xbf2bfaeaf8000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 27
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x7e57f5d5f0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 28
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xfcafebabe0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 29
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xf95fd757c0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 30
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xf2bfaeaf80000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 31
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xe57f5d5f00000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 32
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xcafebabe00000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 33
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x95fd757c00000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 34
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x2bfaeaf800000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 35
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x57f5d5f000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 36
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xafebabe000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 37
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x5fd757c000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 38
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xbfaeaf8000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 39
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x7f5d5f0000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 40
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xfebabe0000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 41
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xfd757c0000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 42
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xfaeaf80000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 43
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xf5d5f00000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 44
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xebabe00000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 45
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xd757c00000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 46
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xaeaf800000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 47
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x5d5f000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 48
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xbabe000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 49
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x757c000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 50
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xeaf8000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 51
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xd5f0000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 52
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xabe0000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 53
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x57c0000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 54
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xaf80000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 55
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x5f00000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 56
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xbe00000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 57
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x7c00000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 58
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xf800000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 59
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xf000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 60
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xe000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 61
    slld(t2, t0, t1)
    //prgchk reg t2 == 0xc000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 62
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x8000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 63
    slld(t2, t0, t1)
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    j exit
