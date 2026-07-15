#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check incremental shifts from 0 to 63.
    li s0, 0xdeadbeefcafebabf
    srlid s2, s0, 0
    //prgchk reg s2 == 0xffffffffffffffffdeadbeefcafebabf
    srlid s2, s0, 1
    //prgchk reg s2 == 0x6f56df77e57f5d5f

    srlid s2, s0, 2
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaf

    srlid s2, s0, 3
    //prgchk reg s2 == 0x1bd5b7ddf95fd757

    srlid s2, s0, 4
    //prgchk reg s2 == 0xdeadbeefcafebab

    srlid s2, s0, 5
    //prgchk reg s2 == 0x6f56df77e57f5d5

    srlid s2, s0, 6
    //prgchk reg s2 == 0x37ab6fbbf2bfaea

    srlid s2, s0, 7
    //prgchk reg s2 == 0x1bd5b7ddf95fd75

    srlid s2, s0, 8
    //prgchk reg s2 == 0xdeadbeefcafeba

    srlid s2, s0, 9
    //prgchk reg s2 == 0x6f56df77e57f5d

    srlid s2, s0, 10
    //prgchk reg s2 == 0x37ab6fbbf2bfae

    srlid s2, s0, 11
    //prgchk reg s2 == 0x1bd5b7ddf95fd7

    srlid s2, s0, 12
    //prgchk reg s2 == 0xdeadbeefcafeb

    srlid s2, s0, 13
    //prgchk reg s2 == 0x6f56df77e57f5

    srlid s2, s0, 14
    //prgchk reg s2 == 0x37ab6fbbf2bfa

    srlid s2, s0, 15
    //prgchk reg s2 == 0x1bd5b7ddf95fd

    srlid s2, s0, 16
    //prgchk reg s2 == 0xdeadbeefcafe

    srlid s2, s0, 17
    //prgchk reg s2 == 0x6f56df77e57f

    srlid s2, s0, 18
    //prgchk reg s2 == 0x37ab6fbbf2bf

    srlid s2, s0, 19
    //prgchk reg s2 == 0x1bd5b7ddf95f

    srlid s2, s0, 20
    //prgchk reg s2 == 0xdeadbeefcaf

    srlid s2, s0, 21
    //prgchk reg s2 == 0x6f56df77e57

    srlid s2, s0, 22
    //prgchk reg s2 == 0x37ab6fbbf2b

    srlid s2, s0, 23
    //prgchk reg s2 == 0x1bd5b7ddf95

    srlid s2, s0, 24
    //prgchk reg s2 == 0xdeadbeefca

    srlid s2, s0, 25
    //prgchk reg s2 == 0x6f56df77e5

    srlid s2, s0, 26
    //prgchk reg s2 == 0x37ab6fbbf2

    srlid s2, s0, 27
    //prgchk reg s2 == 0x1bd5b7ddf9

    srlid s2, s0, 28
    //prgchk reg s2 == 0xdeadbeefc

    srlid s2, s0, 29
    //prgchk reg s2 == 0x6f56df77e

    srlid s2, s0, 30
    //prgchk reg s2 == 0x37ab6fbbf

    srlid s2, s0, 31
    //prgchk reg s2 == 0x1bd5b7ddf

    srlid s2, s0, 32
    //prgchk reg s2 == 0xdeadbeef

    srlid s2, s0, 33
    //prgchk reg s2 == 0x6f56df77

    srlid s2, s0, 34
    //prgchk reg s2 == 0x37ab6fbb

    srlid s2, s0, 35
    //prgchk reg s2 == 0x1bd5b7dd

    srlid s2, s0, 36
    //prgchk reg s2 == 0xdeadbee

    srlid s2, s0, 37
    //prgchk reg s2 == 0x6f56df7

    srlid s2, s0, 38
    //prgchk reg s2 == 0x37ab6fb

    srlid s2, s0, 39
    //prgchk reg s2 == 0x1bd5b7d

    srlid s2, s0, 40
    //prgchk reg s2 == 0xdeadbe

    srlid s2, s0, 41
    //prgchk reg s2 == 0x6f56df

    srlid s2, s0, 42
    //prgchk reg s2 == 0x37ab6f

    srlid s2, s0, 43
    //prgchk reg s2 == 0x1bd5b7

    srlid s2, s0, 44
    //prgchk reg s2 == 0xdeadb

    srlid s2, s0, 45
    //prgchk reg s2 == 0x6f56d

    srlid s2, s0, 46
    //prgchk reg s2 == 0x37ab6

    srlid s2, s0, 47
    //prgchk reg s2 == 0x1bd5b

    srlid s2, s0, 48
    //prgchk reg s2 == 0xdead

    srlid s2, s0, 49
    //prgchk reg s2 == 0x6f56

    srlid s2, s0, 50
    //prgchk reg s2 == 0x37ab

    srlid s2, s0, 51
    //prgchk reg s2 == 0x1bd5

    srlid s2, s0, 52
    //prgchk reg s2 == 0xdea

    srlid s2, s0, 53
    //prgchk reg s2 == 0x6f5

    srlid s2, s0, 54
    //prgchk reg s2 == 0x37a

    srlid s2, s0, 55
    //prgchk reg s2 == 0x1bd

    srlid s2, s0, 56
    //prgchk reg s2 == 0xde

    srlid s2, s0, 57
    //prgchk reg s2 == 0x6f

    srlid s2, s0, 58
    //prgchk reg s2 == 0x37

    srlid s2, s0, 59
    //prgchk reg s2 == 0x1b

    srlid s2, s0, 60
    //prgchk reg s2 == 0xd

    srlid s2, s0, 61
    //prgchk reg s2 == 0x6

    srlid s2, s0, 62
    //prgchk reg s2 == 0x3

    srlid s2, s0, 63
    //prgchk reg s2 == 0x1


    j exit
