#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check incremental shifts from 0 to 63.
    li t0, 0xdeadbeefcafebabf
    srlid t2, t0, 0
    //prgchk reg t2 == 0xffffffffffffffffdeadbeefcafebabf
    srlid t2, t0, 1
    //prgchk reg t2 == 0x6f56df77e57f5d5f

    srlid t2, t0, 2
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaf

    srlid t2, t0, 3
    //prgchk reg t2 == 0x1bd5b7ddf95fd757

    srlid t2, t0, 4
    //prgchk reg t2 == 0xdeadbeefcafebab

    srlid t2, t0, 5
    //prgchk reg t2 == 0x6f56df77e57f5d5

    srlid t2, t0, 6
    //prgchk reg t2 == 0x37ab6fbbf2bfaea

    srlid t2, t0, 7
    //prgchk reg t2 == 0x1bd5b7ddf95fd75

    srlid t2, t0, 8
    //prgchk reg t2 == 0xdeadbeefcafeba

    srlid t2, t0, 9
    //prgchk reg t2 == 0x6f56df77e57f5d

    srlid t2, t0, 10
    //prgchk reg t2 == 0x37ab6fbbf2bfae

    srlid t2, t0, 11
    //prgchk reg t2 == 0x1bd5b7ddf95fd7

    srlid t2, t0, 12
    //prgchk reg t2 == 0xdeadbeefcafeb

    srlid t2, t0, 13
    //prgchk reg t2 == 0x6f56df77e57f5

    srlid t2, t0, 14
    //prgchk reg t2 == 0x37ab6fbbf2bfa

    srlid t2, t0, 15
    //prgchk reg t2 == 0x1bd5b7ddf95fd

    srlid t2, t0, 16
    //prgchk reg t2 == 0xdeadbeefcafe

    srlid t2, t0, 17
    //prgchk reg t2 == 0x6f56df77e57f

    srlid t2, t0, 18
    //prgchk reg t2 == 0x37ab6fbbf2bf

    srlid t2, t0, 19
    //prgchk reg t2 == 0x1bd5b7ddf95f

    srlid t2, t0, 20
    //prgchk reg t2 == 0xdeadbeefcaf

    srlid t2, t0, 21
    //prgchk reg t2 == 0x6f56df77e57

    srlid t2, t0, 22
    //prgchk reg t2 == 0x37ab6fbbf2b

    srlid t2, t0, 23
    //prgchk reg t2 == 0x1bd5b7ddf95

    srlid t2, t0, 24
    //prgchk reg t2 == 0xdeadbeefca

    srlid t2, t0, 25
    //prgchk reg t2 == 0x6f56df77e5

    srlid t2, t0, 26
    //prgchk reg t2 == 0x37ab6fbbf2

    srlid t2, t0, 27
    //prgchk reg t2 == 0x1bd5b7ddf9

    srlid t2, t0, 28
    //prgchk reg t2 == 0xdeadbeefc

    srlid t2, t0, 29
    //prgchk reg t2 == 0x6f56df77e

    srlid t2, t0, 30
    //prgchk reg t2 == 0x37ab6fbbf

    srlid t2, t0, 31
    //prgchk reg t2 == 0x1bd5b7ddf

    srlid t2, t0, 32
    //prgchk reg t2 == 0xdeadbeef

    srlid t2, t0, 33
    //prgchk reg t2 == 0x6f56df77

    srlid t2, t0, 34
    //prgchk reg t2 == 0x37ab6fbb

    srlid t2, t0, 35
    //prgchk reg t2 == 0x1bd5b7dd

    srlid t2, t0, 36
    //prgchk reg t2 == 0xdeadbee

    srlid t2, t0, 37
    //prgchk reg t2 == 0x6f56df7

    srlid t2, t0, 38
    //prgchk reg t2 == 0x37ab6fb

    srlid t2, t0, 39
    //prgchk reg t2 == 0x1bd5b7d

    srlid t2, t0, 40
    //prgchk reg t2 == 0xdeadbe

    srlid t2, t0, 41
    //prgchk reg t2 == 0x6f56df

    srlid t2, t0, 42
    //prgchk reg t2 == 0x37ab6f

    srlid t2, t0, 43
    //prgchk reg t2 == 0x1bd5b7

    srlid t2, t0, 44
    //prgchk reg t2 == 0xdeadb

    srlid t2, t0, 45
    //prgchk reg t2 == 0x6f56d

    srlid t2, t0, 46
    //prgchk reg t2 == 0x37ab6

    srlid t2, t0, 47
    //prgchk reg t2 == 0x1bd5b

    srlid t2, t0, 48
    //prgchk reg t2 == 0xdead

    srlid t2, t0, 49
    //prgchk reg t2 == 0x6f56

    srlid t2, t0, 50
    //prgchk reg t2 == 0x37ab

    srlid t2, t0, 51
    //prgchk reg t2 == 0x1bd5

    srlid t2, t0, 52
    //prgchk reg t2 == 0xdea

    srlid t2, t0, 53
    //prgchk reg t2 == 0x6f5

    srlid t2, t0, 54
    //prgchk reg t2 == 0x37a

    srlid t2, t0, 55
    //prgchk reg t2 == 0x1bd

    srlid t2, t0, 56
    //prgchk reg t2 == 0xde

    srlid t2, t0, 57
    //prgchk reg t2 == 0x6f

    srlid t2, t0, 58
    //prgchk reg t2 == 0x37

    srlid t2, t0, 59
    //prgchk reg t2 == 0x1b

    srlid t2, t0, 60
    //prgchk reg t2 == 0xd

    srlid t2, t0, 61
    //prgchk reg t2 == 0x6

    srlid t2, t0, 62
    //prgchk reg t2 == 0x3

    srlid t2, t0, 63
    //prgchk reg t2 == 0x1


    j exit
