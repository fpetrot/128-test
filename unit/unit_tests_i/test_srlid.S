#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check incremental shifts from 0 to 63.
    li t0, 0xdeadbeefcafebabf
    srlid(t2, t0, 0)
    //prgchk reg t2 == 0xdeadbeefcafebabf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    srlid(t2, t0, 1)
    //prgchk reg t2 == 0x6f56df77e57f5d5f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 2)
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 3)
    //prgchk reg t2 == 0x1bd5b7ddf95fd757
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 4)
    //prgchk reg t2 == 0xdeadbeefcafebab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 5)
    //prgchk reg t2 == 0x6f56df77e57f5d5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 6)
    //prgchk reg t2 == 0x37ab6fbbf2bfaea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 7)
    //prgchk reg t2 == 0x1bd5b7ddf95fd75
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 8)
    //prgchk reg t2 == 0xdeadbeefcafeba
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 9)
    //prgchk reg t2 == 0x6f56df77e57f5d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 10)
    //prgchk reg t2 == 0x37ab6fbbf2bfae
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 11)
    //prgchk reg t2 == 0x1bd5b7ddf95fd7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 12)
    //prgchk reg t2 == 0xdeadbeefcafeb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 13)
    //prgchk reg t2 == 0x6f56df77e57f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 14)
    //prgchk reg t2 == 0x37ab6fbbf2bfa
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 15)
    //prgchk reg t2 == 0x1bd5b7ddf95fd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 16)
    //prgchk reg t2 == 0xdeadbeefcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 17)
    //prgchk reg t2 == 0x6f56df77e57f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 18)
    //prgchk reg t2 == 0x37ab6fbbf2bf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 19)
    //prgchk reg t2 == 0x1bd5b7ddf95f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 20)
    //prgchk reg t2 == 0xdeadbeefcaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 21)
    //prgchk reg t2 == 0x6f56df77e57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 22)
    //prgchk reg t2 == 0x37ab6fbbf2b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 23)
    //prgchk reg t2 == 0x1bd5b7ddf95
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 24)
    //prgchk reg t2 == 0xdeadbeefca
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 25)
    //prgchk reg t2 == 0x6f56df77e5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 26)
    //prgchk reg t2 == 0x37ab6fbbf2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 27)
    //prgchk reg t2 == 0x1bd5b7ddf9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 28)
    //prgchk reg t2 == 0xdeadbeefc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 29)
    //prgchk reg t2 == 0x6f56df77e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 30)
    //prgchk reg t2 == 0x37ab6fbbf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 31)
    //prgchk reg t2 == 0x1bd5b7ddf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 32)
    //prgchk reg t2 == 0xdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 33)
    //prgchk reg t2 == 0x6f56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 34)
    //prgchk reg t2 == 0x37ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 35)
    //prgchk reg t2 == 0x1bd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 36)
    //prgchk reg t2 == 0xdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 37)
    //prgchk reg t2 == 0x6f56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 38)
    //prgchk reg t2 == 0x37ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 39)
    //prgchk reg t2 == 0x1bd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 40)
    //prgchk reg t2 == 0xdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 41)
    //prgchk reg t2 == 0x6f56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 42)
    //prgchk reg t2 == 0x37ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 43)
    //prgchk reg t2 == 0x1bd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 44)
    //prgchk reg t2 == 0xdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 45)
    //prgchk reg t2 == 0x6f56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 46)
    //prgchk reg t2 == 0x37ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 47)
    //prgchk reg t2 == 0x1bd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 48)
    //prgchk reg t2 == 0xdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 49)
    //prgchk reg t2 == 0x6f56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 50)
    //prgchk reg t2 == 0x37ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 51)
    //prgchk reg t2 == 0x1bd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 52)
    //prgchk reg t2 == 0xdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 53)
    //prgchk reg t2 == 0x6f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 54)
    //prgchk reg t2 == 0x37a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 55)
    //prgchk reg t2 == 0x1bd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 56)
    //prgchk reg t2 == 0xde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 57)
    //prgchk reg t2 == 0x6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 58)
    //prgchk reg t2 == 0x37
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 59)
    //prgchk reg t2 == 0x1b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 60)
    //prgchk reg t2 == 0xd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 61)
    //prgchk reg t2 == 0x6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 62)
    //prgchk reg t2 == 0x3
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srlid(t2, t0, 63)
    //prgchk reg t2 == 0x1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0

    j exit
