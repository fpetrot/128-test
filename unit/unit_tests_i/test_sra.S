#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0x80000000000000000000000000000000

    // Check carry of sign bit
    li s6, 127
    sra s2, s0, s6
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // Check carry of zero sign bit.
    li s0, 0x7fffffffffffffffffffffffffffffff
    sra s2, s0, s6
    //prgchk reg s2 == 0

    // Incremental shifts of known value.
    li s0, 0xdeadbeefcafebabfcafed00ddeaddead
    li s1, 0
    sra s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00ddeaddead
    li s1, 1
    sra s2, s0, s1
    //prgchk reg s2 == 0xef56df77e57f5d5fe57f6806ef56ef56
    li s1, 2
    sra s2, s0, s1
    //prgchk reg s2 == 0xf7ab6fbbf2bfaeaff2bfb40377ab77ab
    li s1, 3
    sra s2, s0, s1
    //prgchk reg s2 == 0xfbd5b7ddf95fd757f95fda01bbd5bbd5
    li s1, 4
    sra s2, s0, s1
    //prgchk reg s2 == 0xfdeadbeefcafebabfcafed00ddeaddea
    li s1, 5
    sra s2, s0, s1
    //prgchk reg s2 == 0xfef56df77e57f5d5fe57f6806ef56ef5
    li s1, 6
    sra s2, s0, s1
    //prgchk reg s2 == 0xff7ab6fbbf2bfaeaff2bfb40377ab77a
    li s1, 7
    sra s2, s0, s1
    //prgchk reg s2 == 0xffbd5b7ddf95fd757f95fda01bbd5bbd
    li s1, 8
    sra s2, s0, s1
    //prgchk reg s2 == 0xffdeadbeefcafebabfcafed00ddeadde
    li s1, 9
    sra s2, s0, s1
    //prgchk reg s2 == 0xffef56df77e57f5d5fe57f6806ef56ef
    li s1, 10
    sra s2, s0, s1
    //prgchk reg s2 == 0xfff7ab6fbbf2bfaeaff2bfb40377ab77
    li s1, 11
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffbd5b7ddf95fd757f95fda01bbd5bb
    li s1, 12
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffdeadbeefcafebabfcafed00ddeadd
    li s1, 13
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffef56df77e57f5d5fe57f6806ef56e
    li s1, 14
    sra s2, s0, s1
    //prgchk reg s2 == 0xffff7ab6fbbf2bfaeaff2bfb40377ab7
    li s1, 15
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffbd5b7ddf95fd757f95fda01bbd5b
    li s1, 16
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffdeadbeefcafebabfcafed00ddead
    li s1, 17
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffef56df77e57f5d5fe57f6806ef56
    li s1, 18
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffff7ab6fbbf2bfaeaff2bfb40377ab
    li s1, 19
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffbd5b7ddf95fd757f95fda01bbd5
    li s1, 20
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffdeadbeefcafebabfcafed00ddea
    li s1, 21
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffef56df77e57f5d5fe57f6806ef5
    li s1, 22
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffff7ab6fbbf2bfaeaff2bfb40377a
    li s1, 23
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffbd5b7ddf95fd757f95fda01bbd
    li s1, 24
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffdeadbeefcafebabfcafed00dde
    li s1, 25
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffef56df77e57f5d5fe57f6806ef
    li s1, 26
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffff7ab6fbbf2bfaeaff2bfb40377
    li s1, 27
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffbd5b7ddf95fd757f95fda01bb
    li s1, 28
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffdeadbeefcafebabfcafed00dd
    li s1, 29
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffef56df77e57f5d5fe57f6806e
    li s1, 30
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffff7ab6fbbf2bfaeaff2bfb4037
    li s1, 31
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffbd5b7ddf95fd757f95fda01b
    li s1, 32
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffdeadbeefcafebabfcafed00d
    li s1, 33
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffef56df77e57f5d5fe57f6806
    li s1, 34
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffff7ab6fbbf2bfaeaff2bfb403
    li s1, 35
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffbd5b7ddf95fd757f95fda01
    li s1, 36
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffdeadbeefcafebabfcafed00
    li s1, 37
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffef56df77e57f5d5fe57f680
    li s1, 38
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffff7ab6fbbf2bfaeaff2bfb40
    li s1, 39
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffbd5b7ddf95fd757f95fda0
    li s1, 40
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffdeadbeefcafebabfcafed0
    li s1, 41
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffef56df77e57f5d5fe57f68
    li s1, 42
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffff7ab6fbbf2bfaeaff2bfb4
    li s1, 43
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffbd5b7ddf95fd757f95fda
    li s1, 44
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffdeadbeefcafebabfcafed
    li s1, 45
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffef56df77e57f5d5fe57f6
    li s1, 46
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffff7ab6fbbf2bfaeaff2bfb
    li s1, 47
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffbd5b7ddf95fd757f95fd
    li s1, 48
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffdeadbeefcafebabfcafe
    li s1, 49
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffef56df77e57f5d5fe57f
    li s1, 50
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffff7ab6fbbf2bfaeaff2bf
    li s1, 51
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffbd5b7ddf95fd757f95f
    li s1, 52
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffdeadbeefcafebabfcaf
    li s1, 53
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffef56df77e57f5d5fe57
    li s1, 54
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffff7ab6fbbf2bfaeaff2b
    li s1, 55
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffbd5b7ddf95fd757f95
    li s1, 56
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffdeadbeefcafebabfca
    li s1, 57
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffef56df77e57f5d5fe5
    li s1, 58
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffff7ab6fbbf2bfaeaff2
    li s1, 59
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffbd5b7ddf95fd757f9
    li s1, 60
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffdeadbeefcafebabfc
    li s1, 61
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffef56df77e57f5d5fe
    li s1, 62
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffff7ab6fbbf2bfaeaff
    li s1, 63
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffbd5b7ddf95fd757f
    li s1, 64
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffdeadbeefcafebabf
    li s1, 65
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffef56df77e57f5d5f
    li s1, 66
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff7ab6fbbf2bfaeaf
    li s1, 67
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffbd5b7ddf95fd757
    li s1, 68
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffdeadbeefcafebab
    li s1, 69
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffef56df77e57f5d5
    li s1, 70
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffff7ab6fbbf2bfaea
    li s1, 71
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffbd5b7ddf95fd75
    li s1, 72
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffdeadbeefcafeba
    li s1, 73
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffef56df77e57f5d
    li s1, 74
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffff7ab6fbbf2bfae
    li s1, 75
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffbd5b7ddf95fd7
    li s1, 76
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffdeadbeefcafeb
    li s1, 77
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffef56df77e57f5
    li s1, 78
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffff7ab6fbbf2bfa
    li s1, 79
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffbd5b7ddf95fd
    li s1, 80
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffdeadbeefcafe
    li s1, 81
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffef56df77e57f
    li s1, 82
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffff7ab6fbbf2bf
    li s1, 83
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffbd5b7ddf95f
    li s1, 84
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffdeadbeefcaf
    li s1, 85
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffef56df77e57
    li s1, 86
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffff7ab6fbbf2b
    li s1, 87
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffbd5b7ddf95
    li s1, 88
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffdeadbeefca
    li s1, 89
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffef56df77e5
    li s1, 90
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffff7ab6fbbf2
    li s1, 91
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffbd5b7ddf9
    li s1, 92
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffdeadbeefc
    li s1, 93
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffef56df77e
    li s1, 94
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffff7ab6fbbf
    li s1, 95
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffbd5b7ddf
    li s1, 96
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffdeadbeef
    li s1, 97
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffef56df77
    li s1, 98
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffff7ab6fbb
    li s1, 99
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffbd5b7dd
    li s1, 100
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffdeadbee
    li s1, 101
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffef56df7
    li s1, 102
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffff7ab6fb
    li s1, 103
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffbd5b7d
    li s1, 104
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffdeadbe
    li s1, 105
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffef56df
    li s1, 106
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffff7ab6f
    li s1, 107
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffbd5b7
    li s1, 108
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffdeadb
    li s1, 109
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffef56d
    li s1, 110
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffff7ab6
    li s1, 111
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffbd5b
    li s1, 112
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffdead
    li s1, 113
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffef56
    li s1, 114
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffff7ab
    li s1, 115
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffbd5
    li s1, 116
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffdea
    li s1, 117
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffef5
    li s1, 118
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffff7a
    li s1, 119
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffbd
    li s1, 120
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffde
    li s1, 121
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffef
    li s1, 122
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffff7
    li s1, 123
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffb
    li s1, 124
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffd
    li s1, 125
    sra s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffe
    li s1, 126
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff
    li s1, 127
    sra s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    j exit
