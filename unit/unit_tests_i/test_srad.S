#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check only first 6 bits are used for shift.
    li s0, 0xdeadbeefcafebabe
    li s1, 96 // will correspond to a shift of 32
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef


    // Check incremental shifts from 0 to 63.
    li s0, 0xdeadbeefcafebabf
    li s1, 0
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffdeadbeefcafebabf

    li s1, 1
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffef56df77e57f5d5f

    li s1, 2
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff7ab6fbbf2bfaeaf

    li s1, 3
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffbd5b7ddf95fd757

    li s1, 4
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffdeadbeefcafebab

    li s1, 5
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffef56df77e57f5d5

    li s1, 6
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffff7ab6fbbf2bfaea

    li s1, 7
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffbd5b7ddf95fd75

    li s1, 8
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffdeadbeefcafeba

    li s1, 9
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffef56df77e57f5d

    li s1, 10
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffff7ab6fbbf2bfae

    li s1, 11
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffbd5b7ddf95fd7

    li s1, 12
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffdeadbeefcafeb

    li s1, 13
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffef56df77e57f5

    li s1, 14
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffff7ab6fbbf2bfa

    li s1, 15
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffbd5b7ddf95fd

    li s1, 16
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffdeadbeefcafe

    li s1, 17
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffef56df77e57f

    li s1, 18
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffff7ab6fbbf2bf

    li s1, 19
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffbd5b7ddf95f

    li s1, 20
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffdeadbeefcaf

    li s1, 21
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffef56df77e57

    li s1, 22
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffff7ab6fbbf2b

    li s1, 23
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffbd5b7ddf95

    li s1, 24
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffdeadbeefca

    li s1, 25
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffef56df77e5

    li s1, 26
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffff7ab6fbbf2

    li s1, 27
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffbd5b7ddf9

    li s1, 28
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffdeadbeefc

    li s1, 29
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffef56df77e

    li s1, 30
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffff7ab6fbbf

    li s1, 31
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffbd5b7ddf

    li s1, 32
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef

    li s1, 33
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffef56df77

    li s1, 34
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffff7ab6fbb

    li s1, 35
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffbd5b7dd

    li s1, 36
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffdeadbee

    li s1, 37
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffef56df7

    li s1, 38
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffff7ab6fb

    li s1, 39
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffbd5b7d

    li s1, 40
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffdeadbe

    li s1, 41
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffef56df

    li s1, 42
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffff7ab6f

    li s1, 43
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffbd5b7

    li s1, 44
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffdeadb

    li s1, 45
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffef56d

    li s1, 46
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffff7ab6

    li s1, 47
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffbd5b

    li s1, 48
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffdead

    li s1, 49
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffef56

    li s1, 50
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffff7ab

    li s1, 51
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffbd5

    li s1, 52
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffdea

    li s1, 53
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffef5

    li s1, 54
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffff7a

    li s1, 55
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffbd

    li s1, 56
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffde

    li s1, 57
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffef

    li s1, 58
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffff7

    li s1, 59
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffb

    li s1, 60
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffd

    li s1, 61
    srad s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffe

    li s1, 62
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    li s1, 63
    srad s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    j exit
