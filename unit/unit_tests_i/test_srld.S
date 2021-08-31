#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    // Check only first 6 bits are used for shift.
    li t0, 0xdeadbeefcafebabe
    li t1, 96 // will correspond to a shift of 32
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Check incremental shifts from 0 to 63.
    li t0, 0xdeadbeefcafebabe
    li t1, 0
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefcafebabe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 1
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77e57f5d5f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 2
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 3
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7ddf95fd757
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 4
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefcafebab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 5
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77e57f5d5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 6
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbbf2bfaea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 7
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7ddf95fd75
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 8
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefcafeba
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 9
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77e57f5d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 10
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbbf2bfae
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 11
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7ddf95fd7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 12
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefcafeb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 13
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77e57f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 14
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbbf2bfa
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 15
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7ddf95fd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 16
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 17
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77e57f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 18
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbbf2bf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 19
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7ddf95f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 20
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefcaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 21
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77e57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 22
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbbf2b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 23
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7ddf95
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 24
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefca
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 25
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77e5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 26
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbbf2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 27
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7ddf9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 28
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 29
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 30
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbbf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 31
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7ddf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 32
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 33
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 34
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 35
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 36
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 37
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 38
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 39
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 40
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 41
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 42
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 43
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 44
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 45
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 46
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 47
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 48
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 49
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 50
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 51
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 52
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 53
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 54
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 55
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1bd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 56
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 57
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 58
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x37
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 59
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 60
    srld(t2, t0, t1)
    //prgchk reg t2 == 0xd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 61
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 62
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x3
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 63
    srld(t2, t0, t1)
    //prgchk reg t2 == 0x1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
j exit