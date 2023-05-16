#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0xdeadbeefcafebabe
    sraid t2, t0, 0
    //prgchk reg t2 == 0xffffffffffffffffdeadbeefcafebabe

    sraid t2, t0, 1
    //prgchk reg t2 == 0xffffffffffffffffef56df77e57f5d5f

    sraid t2, t0, 2
    //prgchk reg t2 == 0xfffffffffffffffff7ab6fbbf2bfaeaf

    sraid t2, t0, 3
    //prgchk reg t2 == 0xfffffffffffffffffbd5b7ddf95fd757

    sraid t2, t0, 4
    //prgchk reg t2 == 0xfffffffffffffffffdeadbeefcafebab

    sraid t2, t0, 5
    //prgchk reg t2 == 0xfffffffffffffffffef56df77e57f5d5

    sraid t2, t0, 6
    //prgchk reg t2 == 0xffffffffffffffffff7ab6fbbf2bfaea

    sraid t2, t0, 7
    //prgchk reg t2 == 0xffffffffffffffffffbd5b7ddf95fd75

    sraid t2, t0, 8
    //prgchk reg t2 == 0xffffffffffffffffffdeadbeefcafeba

    sraid t2, t0, 9
    //prgchk reg t2 == 0xffffffffffffffffffef56df77e57f5d

    sraid t2, t0, 10
    //prgchk reg t2 == 0xfffffffffffffffffff7ab6fbbf2bfae

    sraid t2, t0, 11
    //prgchk reg t2 == 0xfffffffffffffffffffbd5b7ddf95fd7

    sraid t2, t0, 12
    //prgchk reg t2 == 0xfffffffffffffffffffdeadbeefcafeb

    sraid t2, t0, 13
    //prgchk reg t2 == 0xfffffffffffffffffffef56df77e57f5

    sraid t2, t0, 14
    //prgchk reg t2 == 0xffffffffffffffffffff7ab6fbbf2bfa

    sraid t2, t0, 15
    //prgchk reg t2 == 0xffffffffffffffffffffbd5b7ddf95fd

    sraid t2, t0, 16
    //prgchk reg t2 == 0xffffffffffffffffffffdeadbeefcafe

    sraid t2, t0, 17
    //prgchk reg t2 == 0xffffffffffffffffffffef56df77e57f

    sraid t2, t0, 18
    //prgchk reg t2 == 0xfffffffffffffffffffff7ab6fbbf2bf

    sraid t2, t0, 19
    //prgchk reg t2 == 0xfffffffffffffffffffffbd5b7ddf95f

    sraid t2, t0, 20
    //prgchk reg t2 == 0xfffffffffffffffffffffdeadbeefcaf

    sraid t2, t0, 21
    //prgchk reg t2 == 0xfffffffffffffffffffffef56df77e57

    sraid t2, t0, 22
    //prgchk reg t2 == 0xffffffffffffffffffffff7ab6fbbf2b

    sraid t2, t0, 23
    //prgchk reg t2 == 0xffffffffffffffffffffffbd5b7ddf95

    sraid t2, t0, 24
    //prgchk reg t2 == 0xffffffffffffffffffffffdeadbeefca

    sraid t2, t0, 25
    //prgchk reg t2 == 0xffffffffffffffffffffffef56df77e5

    sraid t2, t0, 26
    //prgchk reg t2 == 0xfffffffffffffffffffffff7ab6fbbf2

    sraid t2, t0, 27
    //prgchk reg t2 == 0xfffffffffffffffffffffffbd5b7ddf9

    sraid t2, t0, 28
    //prgchk reg t2 == 0xfffffffffffffffffffffffdeadbeefc

    sraid t2, t0, 29
    //prgchk reg t2 == 0xfffffffffffffffffffffffef56df77e

    sraid t2, t0, 30
    //prgchk reg t2 == 0xffffffffffffffffffffffff7ab6fbbf

    sraid t2, t0, 31
    //prgchk reg t2 == 0xffffffffffffffffffffffffbd5b7ddf

    sraid t2, t0, 32
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef

    sraid t2, t0, 33
    //prgchk reg t2 == 0xffffffffffffffffffffffffef56df77

    sraid t2, t0, 34
    //prgchk reg t2 == 0xfffffffffffffffffffffffff7ab6fbb

    sraid t2, t0, 35
    //prgchk reg t2 == 0xfffffffffffffffffffffffffbd5b7dd

    sraid t2, t0, 36
    //prgchk reg t2 == 0xfffffffffffffffffffffffffdeadbee

    sraid t2, t0, 37
    //prgchk reg t2 == 0xfffffffffffffffffffffffffef56df7

    sraid t2, t0, 38
    //prgchk reg t2 == 0xffffffffffffffffffffffffff7ab6fb

    sraid t2, t0, 39
    //prgchk reg t2 == 0xffffffffffffffffffffffffffbd5b7d

    sraid t2, t0, 40
    //prgchk reg t2 == 0xffffffffffffffffffffffffffdeadbe

    sraid t2, t0, 41
    //prgchk reg t2 == 0xffffffffffffffffffffffffffef56df

    sraid t2, t0, 42
    //prgchk reg t2 == 0xfffffffffffffffffffffffffff7ab6f

    sraid t2, t0, 43
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffbd5b7

    sraid t2, t0, 44
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffdeadb

    sraid t2, t0, 45
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffef56d

    sraid t2, t0, 46
    //prgchk reg t2 == 0xffffffffffffffffffffffffffff7ab6

    sraid t2, t0, 47
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffbd5b

    sraid t2, t0, 48
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffdead

    sraid t2, t0, 49
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffef56

    sraid t2, t0, 50
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffff7ab

    sraid t2, t0, 51
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffbd5

    sraid t2, t0, 52
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffdea

    sraid t2, t0, 53
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffef5

    sraid t2, t0, 54
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffff7a

    sraid t2, t0, 55
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffbd

    sraid t2, t0, 56
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffde

    sraid t2, t0, 57
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffef

    sraid t2, t0, 58
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffff7

    sraid t2, t0, 59
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffb

    sraid t2, t0, 60
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffd

    sraid t2, t0, 61
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffe

    sraid t2, t0, 62
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    sraid t2, t0, 63
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    // Last check to make sure zero is extended too
    li t0, 0x2badbabedeadc0de
    sraid t2, t0, 32
    //prgchk reg t2 == 0x0x2badbabe

    j exit
