#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0x80000000000000000000000000000000

    // Check carry of sign bit
    li t6, 127
    sra t2, t0, t6
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    // Check carry of zero sign bit.
    li t0, 0x7fffffffffffffffffffffffffffffff
    sra t2, t0, t6
    //prgchk reg t2 == 0

    // Incremental shifts of known value.
    li t0, 0xdeadbeefcafebabfcafed00ddeaddead
    li t1, 0
    sra t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00ddeaddead
    li t1, 1
    sra t2, t0, t1
    //prgchk reg t2 == 0xef56df77e57f5d5fe57f6806ef56ef56
    li t1, 2
    sra t2, t0, t1
    //prgchk reg t2 == 0xf7ab6fbbf2bfaeaff2bfb40377ab77ab
    li t1, 3
    sra t2, t0, t1
    //prgchk reg t2 == 0xfbd5b7ddf95fd757f95fda01bbd5bbd5
    li t1, 4
    sra t2, t0, t1
    //prgchk reg t2 == 0xfdeadbeefcafebabfcafed00ddeaddea
    li t1, 5
    sra t2, t0, t1
    //prgchk reg t2 == 0xfef56df77e57f5d5fe57f6806ef56ef5
    li t1, 6
    sra t2, t0, t1
    //prgchk reg t2 == 0xff7ab6fbbf2bfaeaff2bfb40377ab77a
    li t1, 7
    sra t2, t0, t1
    //prgchk reg t2 == 0xffbd5b7ddf95fd757f95fda01bbd5bbd
    li t1, 8
    sra t2, t0, t1
    //prgchk reg t2 == 0xffdeadbeefcafebabfcafed00ddeadde
    li t1, 9
    sra t2, t0, t1
    //prgchk reg t2 == 0xffef56df77e57f5d5fe57f6806ef56ef
    li t1, 10
    sra t2, t0, t1
    //prgchk reg t2 == 0xfff7ab6fbbf2bfaeaff2bfb40377ab77
    li t1, 11
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffbd5b7ddf95fd757f95fda01bbd5bb
    li t1, 12
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffdeadbeefcafebabfcafed00ddeadd
    li t1, 13
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffef56df77e57f5d5fe57f6806ef56e
    li t1, 14
    sra t2, t0, t1
    //prgchk reg t2 == 0xffff7ab6fbbf2bfaeaff2bfb40377ab7
    li t1, 15
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffbd5b7ddf95fd757f95fda01bbd5b
    li t1, 16
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffdeadbeefcafebabfcafed00ddead
    li t1, 17
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffef56df77e57f5d5fe57f6806ef56
    li t1, 18
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffff7ab6fbbf2bfaeaff2bfb40377ab
    li t1, 19
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffbd5b7ddf95fd757f95fda01bbd5
    li t1, 20
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffdeadbeefcafebabfcafed00ddea
    li t1, 21
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffef56df77e57f5d5fe57f6806ef5
    li t1, 22
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffff7ab6fbbf2bfaeaff2bfb40377a
    li t1, 23
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffbd5b7ddf95fd757f95fda01bbd
    li t1, 24
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffdeadbeefcafebabfcafed00dde
    li t1, 25
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffef56df77e57f5d5fe57f6806ef
    li t1, 26
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffff7ab6fbbf2bfaeaff2bfb40377
    li t1, 27
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffbd5b7ddf95fd757f95fda01bb
    li t1, 28
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffdeadbeefcafebabfcafed00dd
    li t1, 29
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffef56df77e57f5d5fe57f6806e
    li t1, 30
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffff7ab6fbbf2bfaeaff2bfb4037
    li t1, 31
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffbd5b7ddf95fd757f95fda01b
    li t1, 32
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffdeadbeefcafebabfcafed00d
    li t1, 33
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffef56df77e57f5d5fe57f6806
    li t1, 34
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffff7ab6fbbf2bfaeaff2bfb403
    li t1, 35
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffbd5b7ddf95fd757f95fda01
    li t1, 36
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffdeadbeefcafebabfcafed00
    li t1, 37
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffef56df77e57f5d5fe57f680
    li t1, 38
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffff7ab6fbbf2bfaeaff2bfb40
    li t1, 39
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffbd5b7ddf95fd757f95fda0
    li t1, 40
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffdeadbeefcafebabfcafed0
    li t1, 41
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffef56df77e57f5d5fe57f68
    li t1, 42
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffff7ab6fbbf2bfaeaff2bfb4
    li t1, 43
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffbd5b7ddf95fd757f95fda
    li t1, 44
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffdeadbeefcafebabfcafed
    li t1, 45
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffef56df77e57f5d5fe57f6
    li t1, 46
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffff7ab6fbbf2bfaeaff2bfb
    li t1, 47
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffbd5b7ddf95fd757f95fd
    li t1, 48
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffdeadbeefcafebabfcafe
    li t1, 49
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffef56df77e57f5d5fe57f
    li t1, 50
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffff7ab6fbbf2bfaeaff2bf
    li t1, 51
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffbd5b7ddf95fd757f95f
    li t1, 52
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffdeadbeefcafebabfcaf
    li t1, 53
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffef56df77e57f5d5fe57
    li t1, 54
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffff7ab6fbbf2bfaeaff2b
    li t1, 55
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffbd5b7ddf95fd757f95
    li t1, 56
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffdeadbeefcafebabfca
    li t1, 57
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffef56df77e57f5d5fe5
    li t1, 58
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffff7ab6fbbf2bfaeaff2
    li t1, 59
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffbd5b7ddf95fd757f9
    li t1, 60
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffdeadbeefcafebabfc
    li t1, 61
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffef56df77e57f5d5fe
    li t1, 62
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff7ab6fbbf2bfaeaff
    li t1, 63
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffbd5b7ddf95fd757f
    li t1, 64
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffdeadbeefcafebabf
    li t1, 65
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffef56df77e57f5d5f
    li t1, 66
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff7ab6fbbf2bfaeaf
    li t1, 67
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffbd5b7ddf95fd757
    li t1, 68
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffdeadbeefcafebab
    li t1, 69
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffef56df77e57f5d5
    li t1, 70
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffff7ab6fbbf2bfaea
    li t1, 71
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffbd5b7ddf95fd75
    li t1, 72
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffdeadbeefcafeba
    li t1, 73
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffef56df77e57f5d
    li t1, 74
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffff7ab6fbbf2bfae
    li t1, 75
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffbd5b7ddf95fd7
    li t1, 76
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffdeadbeefcafeb
    li t1, 77
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffef56df77e57f5
    li t1, 78
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffff7ab6fbbf2bfa
    li t1, 79
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffbd5b7ddf95fd
    li t1, 80
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffdeadbeefcafe
    li t1, 81
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffef56df77e57f
    li t1, 82
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffff7ab6fbbf2bf
    li t1, 83
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffbd5b7ddf95f
    li t1, 84
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffdeadbeefcaf
    li t1, 85
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffef56df77e57
    li t1, 86
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffff7ab6fbbf2b
    li t1, 87
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffbd5b7ddf95
    li t1, 88
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffdeadbeefca
    li t1, 89
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffef56df77e5
    li t1, 90
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffff7ab6fbbf2
    li t1, 91
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffbd5b7ddf9
    li t1, 92
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffdeadbeefc
    li t1, 93
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffef56df77e
    li t1, 94
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffff7ab6fbbf
    li t1, 95
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffbd5b7ddf
    li t1, 96
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffdeadbeef
    li t1, 97
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffef56df77
    li t1, 98
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffff7ab6fbb
    li t1, 99
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffbd5b7dd
    li t1, 100
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffdeadbee
    li t1, 101
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffef56df7
    li t1, 102
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffff7ab6fb
    li t1, 103
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffbd5b7d
    li t1, 104
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffdeadbe
    li t1, 105
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffef56df
    li t1, 106
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffff7ab6f
    li t1, 107
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffbd5b7
    li t1, 108
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffdeadb
    li t1, 109
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffef56d
    li t1, 110
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffff7ab6
    li t1, 111
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffbd5b
    li t1, 112
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffdead
    li t1, 113
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffef56
    li t1, 114
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffff7ab
    li t1, 115
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffbd5
    li t1, 116
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffdea
    li t1, 117
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffef5
    li t1, 118
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffff7a
    li t1, 119
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffbd
    li t1, 120
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffde
    li t1, 121
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffef
    li t1, 122
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffff7
    li t1, 123
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffb
    li t1, 124
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffd
    li t1, 125
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffffffffffffffffe
    li t1, 126
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff
    li t1, 127
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffff

    j exit
