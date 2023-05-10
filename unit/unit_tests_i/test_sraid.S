#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0xdeadbeefcafebabe
    sraid(t2, t0, 0)
    //prgchk reg t2 == 0xffffffffffffffffdeadbeefcafebabe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 1)
    //prgchk reg t2 == 0xffffffffffffffffef56df77e57f5d5f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 2)
    //prgchk reg t2 == 0xfffffffffffffffff7ab6fbbf2bfaeaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 3)
    //prgchk reg t2 == 0xfffffffffffffffffbd5b7ddf95fd757
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 4)
    //prgchk reg t2 == 0xfffffffffffffffffdeadbeefcafebab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 5)
    //prgchk reg t2 == 0xfffffffffffffffffef56df77e57f5d5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 6)
    //prgchk reg t2 == 0xffffffffffffffffff7ab6fbbf2bfaea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 7)
    //prgchk reg t2 == 0xffffffffffffffffffbd5b7ddf95fd75
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 8)
    //prgchk reg t2 == 0xffffffffffffffffffdeadbeefcafeba
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 9)
    //prgchk reg t2 == 0xffffffffffffffffffef56df77e57f5d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 10)
    //prgchk reg t2 == 0xfffffffffffffffffff7ab6fbbf2bfae
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 11)
    //prgchk reg t2 == 0xfffffffffffffffffffbd5b7ddf95fd7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 12)
    //prgchk reg t2 == 0xfffffffffffffffffffdeadbeefcafeb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 13)
    //prgchk reg t2 == 0xfffffffffffffffffffef56df77e57f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 14)
    //prgchk reg t2 == 0xffffffffffffffffffff7ab6fbbf2bfa
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 15)
    //prgchk reg t2 == 0xffffffffffffffffffffbd5b7ddf95fd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 16)
    //prgchk reg t2 == 0xffffffffffffffffffffdeadbeefcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 17)
    //prgchk reg t2 == 0xffffffffffffffffffffef56df77e57f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 18)
    //prgchk reg t2 == 0xfffffffffffffffffffff7ab6fbbf2bf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 19)
    //prgchk reg t2 == 0xfffffffffffffffffffffbd5b7ddf95f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 20)
    //prgchk reg t2 == 0xfffffffffffffffffffffdeadbeefcaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 21)
    //prgchk reg t2 == 0xfffffffffffffffffffffef56df77e57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 22)
    //prgchk reg t2 == 0xffffffffffffffffffffff7ab6fbbf2b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 23)
    //prgchk reg t2 == 0xffffffffffffffffffffffbd5b7ddf95
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 24)
    //prgchk reg t2 == 0xffffffdeadbeefca
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 25)
    //prgchk reg t2 == 0xffffffef56df77e5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 26)
    //prgchk reg t2 == 0xfffffff7ab6fbbf2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 27)
    //prgchk reg t2 == 0xfffffffbd5b7ddf9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 28)
    //prgchk reg t2 == 0xfffffffdeadbeefc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 29)
    //prgchk reg t2 == 0xfffffffef56df77e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 30)
    //prgchk reg t2 == 0xffffffff7ab6fbbf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 31)
    //prgchk reg t2 == 0xffffffffbd5b7ddf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 32)
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 33)
    //prgchk reg t2 == 0xffffffffef56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 34)
    //prgchk reg t2 == 0xfffffffff7ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 35)
    //prgchk reg t2 == 0xfffffffffbd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 36)
    //prgchk reg t2 == 0xfffffffffdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 37)
    //prgchk reg t2 == 0xfffffffffef56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 38)
    //prgchk reg t2 == 0xffffffffff7ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 39)
    //prgchk reg t2 == 0xffffffffffbd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 40)
    //prgchk reg t2 == 0xffffffffffdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 41)
    //prgchk reg t2 == 0xffffffffffef56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 42)
    //prgchk reg t2 == 0xfffffffffff7ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 43)
    //prgchk reg t2 == 0xfffffffffffbd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 44)
    //prgchk reg t2 == 0xfffffffffffdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 45)
    //prgchk reg t2 == 0xfffffffffffef56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 46)
    //prgchk reg t2 == 0xffffffffffff7ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 47)
    //prgchk reg t2 == 0xffffffffffffbd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 48)
    //prgchk reg t2 == 0xffffffffffffdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 49)
    //prgchk reg t2 == 0xffffffffffffef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 50)
    //prgchk reg t2 == 0xfffffffffffff7ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 51)
    //prgchk reg t2 == 0xfffffffffffffbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 52)
    //prgchk reg t2 == 0xfffffffffffffdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 53)
    //prgchk reg t2 == 0xfffffffffffffef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 54)
    //prgchk reg t2 == 0xffffffffffffff7a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 55)
    //prgchk reg t2 == 0xffffffffffffffbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 56)
    //prgchk reg t2 == 0xffffffffffffffde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 57)
    //prgchk reg t2 == 0xffffffffffffffef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 58)
    //prgchk reg t2 == 0xfffffffffffffff7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 59)
    //prgchk reg t2 == 0xfffffffffffffffb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 60)
    //prgchk reg t2 == 0xfffffffffffffffd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 61)
    //prgchk reg t2 == 0xfffffffffffffffe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 62)
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraid(t2, t0, 63)
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    j exit
