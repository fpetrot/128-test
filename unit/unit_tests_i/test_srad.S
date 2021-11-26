#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check only first 6 bits are used for shift.
    li t0, 0xdeadbeefcafebabe
    li t1, 96 // will correspond to a shift of 32
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Check incremental shifts from 0 to 63.
    li t0, 0xdeadbeefcafebabf
    li t1, 0
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xdeadbeefcafebabf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 1
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xef56df77e57f5d5f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 2
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xf7ab6fbbf2bfaeaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 3
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfbd5b7ddf95fd757
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 4
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfdeadbeefcafebab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 5
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfef56df77e57f5d5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 6
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xff7ab6fbbf2bfaea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 7
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffbd5b7ddf95fd75
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 8
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffdeadbeefcafeba
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 9
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffef56df77e57f5d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 10
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfff7ab6fbbf2bfae
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 11
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffbd5b7ddf95fd7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 12
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffdeadbeefcafeb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 13
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffef56df77e57f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 14
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffff7ab6fbbf2bfa
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 15
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffbd5b7ddf95fd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 16
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffdeadbeefcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 17
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffef56df77e57f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 18
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffff7ab6fbbf2bf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 19
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffbd5b7ddf95f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 20
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffdeadbeefcaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 21
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffef56df77e57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 22
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffff7ab6fbbf2b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 23
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffbd5b7ddf95
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 24
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffdeadbeefca
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 25
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffef56df77e5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 26
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffff7ab6fbbf2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 27
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffbd5b7ddf9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 28
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffdeadbeefc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 29
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffef56df77e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 30
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffff7ab6fbbf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 31
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffbd5b7ddf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 32
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 33
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffef56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 34
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffff7ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 35
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffbd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 36
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 37
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffef56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 38
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffff7ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 39
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffbd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 40
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 41
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffef56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 42
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffff7ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 43
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffbd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 44
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 45
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffef56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 46
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffff7ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 47
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffbd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 48
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 49
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 50
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffff7ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 51
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffffbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 52
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffffdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 53
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffffef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 54
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffff7a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 55
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffffbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 56
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffffde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 57
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffffef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 58
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffffff7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 59
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffffffb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 60
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffffffd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 61
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xfffffffffffffffe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 62
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 63
    srad(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    j exit
