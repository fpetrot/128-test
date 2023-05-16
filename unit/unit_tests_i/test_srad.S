#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check only first 6 bits are used for shift.
    li t0, 0xdeadbeefcafebabe
    li t1, 96 // will correspond to a shift of 32
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef


    // Check incremental shifts from 0 to 63.
    li t0, 0xdeadbeefcafebabf
    li t1, 0
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffdeadbeefcafebabf

    li t1, 1
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffef56df77e57f5d5f

    li t1, 2
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff7ab6fbbf2bfaeaf

    li t1, 3
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffbd5b7ddf95fd757

    li t1, 4
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffdeadbeefcafebab

    li t1, 5
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffef56df77e57f5d5

    li t1, 6
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffff7ab6fbbf2bfaea

    li t1, 7
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffbd5b7ddf95fd75

    li t1, 8
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffdeadbeefcafeba

    li t1, 9
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffef56df77e57f5d

    li t1, 10
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffff7ab6fbbf2bfae

    li t1, 11
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffbd5b7ddf95fd7

    li t1, 12
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffdeadbeefcafeb

    li t1, 13
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffef56df77e57f5

    li t1, 14
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffff7ab6fbbf2bfa

    li t1, 15
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffbd5b7ddf95fd

    li t1, 16
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffdeadbeefcafe

    li t1, 17
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffef56df77e57f

    li t1, 18
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffff7ab6fbbf2bf

    li t1, 19
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffbd5b7ddf95f

    li t1, 20
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffdeadbeefcaf

    li t1, 21
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffef56df77e57

    li t1, 22
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffff7ab6fbbf2b

    li t1, 23
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffbd5b7ddf95

    li t1, 24
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffdeadbeefca

    li t1, 25
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffef56df77e5

    li t1, 26
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffff7ab6fbbf2

    li t1, 27
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffbd5b7ddf9

    li t1, 28
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffdeadbeefc

    li t1, 29
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffef56df77e

    li t1, 30
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffff7ab6fbbf

    li t1, 31
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffbd5b7ddf

    li t1, 32
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef

    li t1, 33
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffef56df77

    li t1, 34
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffff7ab6fbb

    li t1, 35
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffbd5b7dd

    li t1, 36
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffdeadbee

    li t1, 37
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffef56df7

    li t1, 38
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffff7ab6fb

    li t1, 39
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffbd5b7d

    li t1, 40
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffdeadbe

    li t1, 41
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffef56df

    li t1, 42
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffff7ab6f

    li t1, 43
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffbd5b7

    li t1, 44
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffdeadb

    li t1, 45
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffef56d

    li t1, 46
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffff7ab6

    li t1, 47
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffbd5b

    li t1, 48
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffdead

    li t1, 49
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffef56

    li t1, 50
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffff7ab

    li t1, 51
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffbd5

    li t1, 52
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffdea

    li t1, 53
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffef5

    li t1, 54
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffff7a

    li t1, 55
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffbd

    li t1, 56
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffde

    li t1, 57
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffef

    li t1, 58
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffff7

    li t1, 59
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffb

    li t1, 60
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffd

    li t1, 61
    srad t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffe

    li t1, 62
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    li t1, 63
    srad t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    j exit
