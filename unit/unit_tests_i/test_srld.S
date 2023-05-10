#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check only first 6 bits are used for shift.
    li t0, 0xdeadbeefcafebabe
    li t1, 96 // will correspond to a shift of 32
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeef


    // Check incremental shifts from 0 to 63.
    li t0, 0xdeadbeefcafebabe
    li t1, 0
    srld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffdeadbeefcafebabe

    li t1, 1
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5f

    li t1, 2
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaf

    li t1, 3
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757

    li t1, 4
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebab

    li t1, 5
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5

    li t1, 6
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaea

    li t1, 7
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd75

    li t1, 8
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafeba

    li t1, 9
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d

    li t1, 10
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfae

    li t1, 11
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd7

    li t1, 12
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafeb

    li t1, 13
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5

    li t1, 14
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfa

    li t1, 15
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd

    li t1, 16
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafe

    li t1, 17
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f

    li t1, 18
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bf

    li t1, 19
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95f

    li t1, 20
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcaf

    li t1, 21
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57

    li t1, 22
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2b

    li t1, 23
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95

    li t1, 24
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefca

    li t1, 25
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e5

    li t1, 26
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2

    li t1, 27
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf9

    li t1, 28
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefc

    li t1, 29
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e

    li t1, 30
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf

    li t1, 31
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf

    li t1, 32
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbeef

    li t1, 33
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df77

    li t1, 34
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbb

    li t1, 35
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7dd

    li t1, 36
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbee

    li t1, 37
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df7

    li t1, 38
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6fb

    li t1, 39
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7d

    li t1, 40
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadbe

    li t1, 41
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56df

    li t1, 42
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6f

    li t1, 43
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7

    li t1, 44
    srld t2, t0, t1
    //prgchk reg t2 == 0xdeadb

    li t1, 45
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56d

    li t1, 46
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab6

    li t1, 47
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5b

    li t1, 48
    srld t2, t0, t1
    //prgchk reg t2 == 0xdead

    li t1, 49
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f56

    li t1, 50
    srld t2, t0, t1
    //prgchk reg t2 == 0x37ab

    li t1, 51
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd5

    li t1, 52
    srld t2, t0, t1
    //prgchk reg t2 == 0xdea

    li t1, 53
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f5

    li t1, 54
    srld t2, t0, t1
    //prgchk reg t2 == 0x37a

    li t1, 55
    srld t2, t0, t1
    //prgchk reg t2 == 0x1bd

    li t1, 56
    srld t2, t0, t1
    //prgchk reg t2 == 0xde

    li t1, 57
    srld t2, t0, t1
    //prgchk reg t2 == 0x6f

    li t1, 58
    srld t2, t0, t1
    //prgchk reg t2 == 0x37

    li t1, 59
    srld t2, t0, t1
    //prgchk reg t2 == 0x1b

    li t1, 60
    srld t2, t0, t1
    //prgchk reg t2 == 0xd

    li t1, 61
    srld t2, t0, t1
    //prgchk reg t2 == 0x6

    li t1, 62
    srld t2, t0, t1
    //prgchk reg t2 == 0x3

    li t1, 63
    srld t2, t0, t1
    //prgchk reg t2 == 0x1

    j exit
