#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0xdeadbeefcafebabe
    sraid s2, s0, 0
    //prgchk reg s2 == 0xffffffffffffffffdeadbeefcafebabe

    sraid s2, s0, 1
    //prgchk reg s2 == 0xffffffffffffffffef56df77e57f5d5f

    sraid s2, s0, 2
    //prgchk reg s2 == 0xfffffffffffffffff7ab6fbbf2bfaeaf

    sraid s2, s0, 3
    //prgchk reg s2 == 0xfffffffffffffffffbd5b7ddf95fd757

    sraid s2, s0, 4
    //prgchk reg s2 == 0xfffffffffffffffffdeadbeefcafebab

    sraid s2, s0, 5
    //prgchk reg s2 == 0xfffffffffffffffffef56df77e57f5d5

    sraid s2, s0, 6
    //prgchk reg s2 == 0xffffffffffffffffff7ab6fbbf2bfaea

    sraid s2, s0, 7
    //prgchk reg s2 == 0xffffffffffffffffffbd5b7ddf95fd75

    sraid s2, s0, 8
    //prgchk reg s2 == 0xffffffffffffffffffdeadbeefcafeba

    sraid s2, s0, 9
    //prgchk reg s2 == 0xffffffffffffffffffef56df77e57f5d

    sraid s2, s0, 10
    //prgchk reg s2 == 0xfffffffffffffffffff7ab6fbbf2bfae

    sraid s2, s0, 11
    //prgchk reg s2 == 0xfffffffffffffffffffbd5b7ddf95fd7

    sraid s2, s0, 12
    //prgchk reg s2 == 0xfffffffffffffffffffdeadbeefcafeb

    sraid s2, s0, 13
    //prgchk reg s2 == 0xfffffffffffffffffffef56df77e57f5

    sraid s2, s0, 14
    //prgchk reg s2 == 0xffffffffffffffffffff7ab6fbbf2bfa

    sraid s2, s0, 15
    //prgchk reg s2 == 0xffffffffffffffffffffbd5b7ddf95fd

    sraid s2, s0, 16
    //prgchk reg s2 == 0xffffffffffffffffffffdeadbeefcafe

    sraid s2, s0, 17
    //prgchk reg s2 == 0xffffffffffffffffffffef56df77e57f

    sraid s2, s0, 18
    //prgchk reg s2 == 0xfffffffffffffffffffff7ab6fbbf2bf

    sraid s2, s0, 19
    //prgchk reg s2 == 0xfffffffffffffffffffffbd5b7ddf95f

    sraid s2, s0, 20
    //prgchk reg s2 == 0xfffffffffffffffffffffdeadbeefcaf

    sraid s2, s0, 21
    //prgchk reg s2 == 0xfffffffffffffffffffffef56df77e57

    sraid s2, s0, 22
    //prgchk reg s2 == 0xffffffffffffffffffffff7ab6fbbf2b

    sraid s2, s0, 23
    //prgchk reg s2 == 0xffffffffffffffffffffffbd5b7ddf95

    sraid s2, s0, 24
    //prgchk reg s2 == 0xffffffffffffffffffffffdeadbeefca

    sraid s2, s0, 25
    //prgchk reg s2 == 0xffffffffffffffffffffffef56df77e5

    sraid s2, s0, 26
    //prgchk reg s2 == 0xfffffffffffffffffffffff7ab6fbbf2

    sraid s2, s0, 27
    //prgchk reg s2 == 0xfffffffffffffffffffffffbd5b7ddf9

    sraid s2, s0, 28
    //prgchk reg s2 == 0xfffffffffffffffffffffffdeadbeefc

    sraid s2, s0, 29
    //prgchk reg s2 == 0xfffffffffffffffffffffffef56df77e

    sraid s2, s0, 30
    //prgchk reg s2 == 0xffffffffffffffffffffffff7ab6fbbf

    sraid s2, s0, 31
    //prgchk reg s2 == 0xffffffffffffffffffffffffbd5b7ddf

    sraid s2, s0, 32
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef

    sraid s2, s0, 33
    //prgchk reg s2 == 0xffffffffffffffffffffffffef56df77

    sraid s2, s0, 34
    //prgchk reg s2 == 0xfffffffffffffffffffffffff7ab6fbb

    sraid s2, s0, 35
    //prgchk reg s2 == 0xfffffffffffffffffffffffffbd5b7dd

    sraid s2, s0, 36
    //prgchk reg s2 == 0xfffffffffffffffffffffffffdeadbee

    sraid s2, s0, 37
    //prgchk reg s2 == 0xfffffffffffffffffffffffffef56df7

    sraid s2, s0, 38
    //prgchk reg s2 == 0xffffffffffffffffffffffffff7ab6fb

    sraid s2, s0, 39
    //prgchk reg s2 == 0xffffffffffffffffffffffffffbd5b7d

    sraid s2, s0, 40
    //prgchk reg s2 == 0xffffffffffffffffffffffffffdeadbe

    sraid s2, s0, 41
    //prgchk reg s2 == 0xffffffffffffffffffffffffffef56df

    sraid s2, s0, 42
    //prgchk reg s2 == 0xfffffffffffffffffffffffffff7ab6f

    sraid s2, s0, 43
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffbd5b7

    sraid s2, s0, 44
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffdeadb

    sraid s2, s0, 45
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffef56d

    sraid s2, s0, 46
    //prgchk reg s2 == 0xffffffffffffffffffffffffffff7ab6

    sraid s2, s0, 47
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffbd5b

    sraid s2, s0, 48
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffdead

    sraid s2, s0, 49
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffef56

    sraid s2, s0, 50
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffff7ab

    sraid s2, s0, 51
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffbd5

    sraid s2, s0, 52
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffdea

    sraid s2, s0, 53
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffef5

    sraid s2, s0, 54
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffff7a

    sraid s2, s0, 55
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffbd

    sraid s2, s0, 56
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffde

    sraid s2, s0, 57
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffef

    sraid s2, s0, 58
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffff7

    sraid s2, s0, 59
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffb

    sraid s2, s0, 60
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffd

    sraid s2, s0, 61
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffe

    sraid s2, s0, 62
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    sraid s2, s0, 63
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // Last check to make sure zero is extended too
    li s0, 0x2badbabedeadc0de
    sraid s2, s0, 32
    //prgchk reg s2 == 0x2badbabe

    j exit
