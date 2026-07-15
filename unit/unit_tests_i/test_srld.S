#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check only first 6 bits are used for shift.
    li s0, 0xdeadbeefcafebabe
    li s1, 96 // will correspond to a shift of 32
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeef


    // Check incremental shifts from 0 to 63.
    li s0, 0xdeadbeefcafebabe
    li s1, 0
    srld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffdeadbeefcafebabe

    li s1, 1
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5f

    li s1, 2
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaf

    li s1, 3
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757

    li s1, 4
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebab

    li s1, 5
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5

    li s1, 6
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaea

    li s1, 7
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd75

    li s1, 8
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafeba

    li s1, 9
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d

    li s1, 10
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfae

    li s1, 11
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd7

    li s1, 12
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafeb

    li s1, 13
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5

    li s1, 14
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfa

    li s1, 15
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd

    li s1, 16
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafe

    li s1, 17
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f

    li s1, 18
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bf

    li s1, 19
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95f

    li s1, 20
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcaf

    li s1, 21
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57

    li s1, 22
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2b

    li s1, 23
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95

    li s1, 24
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefca

    li s1, 25
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e5

    li s1, 26
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2

    li s1, 27
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf9

    li s1, 28
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefc

    li s1, 29
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e

    li s1, 30
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf

    li s1, 31
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf

    li s1, 32
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbeef

    li s1, 33
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df77

    li s1, 34
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbb

    li s1, 35
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7dd

    li s1, 36
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbee

    li s1, 37
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df7

    li s1, 38
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6fb

    li s1, 39
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7d

    li s1, 40
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadbe

    li s1, 41
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56df

    li s1, 42
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6f

    li s1, 43
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7

    li s1, 44
    srld s2, s0, s1
    //prgchk reg s2 == 0xdeadb

    li s1, 45
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56d

    li s1, 46
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab6

    li s1, 47
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5b

    li s1, 48
    srld s2, s0, s1
    //prgchk reg s2 == 0xdead

    li s1, 49
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f56

    li s1, 50
    srld s2, s0, s1
    //prgchk reg s2 == 0x37ab

    li s1, 51
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd5

    li s1, 52
    srld s2, s0, s1
    //prgchk reg s2 == 0xdea

    li s1, 53
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f5

    li s1, 54
    srld s2, s0, s1
    //prgchk reg s2 == 0x37a

    li s1, 55
    srld s2, s0, s1
    //prgchk reg s2 == 0x1bd

    li s1, 56
    srld s2, s0, s1
    //prgchk reg s2 == 0xde

    li s1, 57
    srld s2, s0, s1
    //prgchk reg s2 == 0x6f

    li s1, 58
    srld s2, s0, s1
    //prgchk reg s2 == 0x37

    li s1, 59
    srld s2, s0, s1
    //prgchk reg s2 == 0x1b

    li s1, 60
    srld s2, s0, s1
    //prgchk reg s2 == 0xd

    li s1, 61
    srld s2, s0, s1
    //prgchk reg s2 == 0x6

    li s1, 62
    srld s2, s0, s1
    //prgchk reg s2 == 0x3

    li s1, 63
    srld s2, s0, s1
    //prgchk reg s2 == 0x1

    j exit
