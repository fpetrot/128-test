#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    liu(t0, 0x8000000000000000)
    slli(t1, t0, 64)

    // Check carry of sign bit
    li t6, 127
    sra t2, t1, t6
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Check carry of zero sign bit.
    liu(t0, 0x7fffffffffffffff)
    slli(t1, t0, 64)
    sra t2, t1, t6
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Incremental shifts of known value.
    liu(t0, 0xdeadbeefcafebabf)
    slli(t0, t0, 64)
    liu(t1, 0xcafed00ddeaddead)
    or t0, t0, t1
    li t1, 0
    sra t2, t0, t1
    //prgchk reg t2 == 0xcafed00ddeaddead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefcafebabf
    li t1, 1
    sra t2, t0, t1
    //prgchk reg t2 == 0xe57f6806ef56ef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xef56df77e57f5d5f
    li t1, 2
    sra t2, t0, t1
    //prgchk reg t2 == 0xf2bfb40377ab77ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf7ab6fbbf2bfaeaf
    li t1, 3
    sra t2, t0, t1
    //prgchk reg t2 == 0xf95fda01bbd5bbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfbd5b7ddf95fd757
    li t1, 4
    sra t2, t0, t1
    //prgchk reg t2 == 0xfcafed00ddeaddea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfdeadbeefcafebab
    li t1, 5
    sra t2, t0, t1
    //prgchk reg t2 == 0xfe57f6806ef56ef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfef56df77e57f5d5
    li t1, 6
    sra t2, t0, t1
    //prgchk reg t2 == 0xff2bfb40377ab77a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xff7ab6fbbf2bfaea
    li t1, 7
    sra t2, t0, t1
    //prgchk reg t2 == 0x7f95fda01bbd5bbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffbd5b7ddf95fd75
    li t1, 8
    sra t2, t0, t1
    //prgchk reg t2 == 0xbfcafed00ddeadde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffdeadbeefcafeba
    li t1, 9
    sra t2, t0, t1
    //prgchk reg t2 == 0x5fe57f6806ef56ef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffef56df77e57f5d
    li t1, 10
    sra t2, t0, t1
    //prgchk reg t2 == 0xaff2bfb40377ab77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfff7ab6fbbf2bfae
    li t1, 11
    sra t2, t0, t1
    //prgchk reg t2 == 0x57f95fda01bbd5bb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffbd5b7ddf95fd7
    li t1, 12
    sra t2, t0, t1
    //prgchk reg t2 == 0xabfcafed00ddeadd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffdeadbeefcafeb
    li t1, 13
    sra t2, t0, t1
    //prgchk reg t2 == 0xd5fe57f6806ef56e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffef56df77e57f5
    li t1, 14
    sra t2, t0, t1
    //prgchk reg t2 == 0xeaff2bfb40377ab7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffff7ab6fbbf2bfa
    li t1, 15
    sra t2, t0, t1
    //prgchk reg t2 == 0x757f95fda01bbd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffbd5b7ddf95fd
    li t1, 16
    sra t2, t0, t1
    //prgchk reg t2 == 0xbabfcafed00ddead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffdeadbeefcafe
    li t1, 17
    sra t2, t0, t1
    //prgchk reg t2 == 0x5d5fe57f6806ef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffef56df77e57f
    li t1, 18
    sra t2, t0, t1
    //prgchk reg t2 == 0xaeaff2bfb40377ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffff7ab6fbbf2bf
    li t1, 19
    sra t2, t0, t1
    //prgchk reg t2 == 0xd757f95fda01bbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffbd5b7ddf95f
    li t1, 20
    sra t2, t0, t1
    //prgchk reg t2 == 0xebabfcafed00ddea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffdeadbeefcaf
    li t1, 21
    sra t2, t0, t1
    //prgchk reg t2 == 0xf5d5fe57f6806ef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffef56df77e57
    li t1, 22
    sra t2, t0, t1
    //prgchk reg t2 == 0xfaeaff2bfb40377a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffff7ab6fbbf2b
    li t1, 23
    sra t2, t0, t1
    //prgchk reg t2 == 0xfd757f95fda01bbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffbd5b7ddf95
    li t1, 24
    sra t2, t0, t1
    //prgchk reg t2 == 0xfebabfcafed00dde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffdeadbeefca
    li t1, 25
    sra t2, t0, t1
    //prgchk reg t2 == 0x7f5d5fe57f6806ef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffef56df77e5
    li t1, 26
    sra t2, t0, t1
    //prgchk reg t2 == 0xbfaeaff2bfb40377
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffff7ab6fbbf2
    li t1, 27
    sra t2, t0, t1
    //prgchk reg t2 == 0x5fd757f95fda01bb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffbd5b7ddf9
    li t1, 28
    sra t2, t0, t1
    //prgchk reg t2 == 0xafebabfcafed00dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffdeadbeefc
    li t1, 29
    sra t2, t0, t1
    //prgchk reg t2 == 0x57f5d5fe57f6806e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffef56df77e
    li t1, 30
    sra t2, t0, t1
    //prgchk reg t2 == 0x2bfaeaff2bfb4037
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffff7ab6fbbf
    li t1, 31
    sra t2, t0, t1
    //prgchk reg t2 == 0x95fd757f95fda01b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffbd5b7ddf
    li t1, 32
    sra t2, t0, t1
    //prgchk reg t2 == 0xcafebabfcafed00d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffdeadbeef
    li t1, 33
    sra t2, t0, t1
    //prgchk reg t2 == 0xe57f5d5fe57f6806
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffef56df77
    li t1, 34
    sra t2, t0, t1
    //prgchk reg t2 == 0xf2bfaeaff2bfb403
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffff7ab6fbb
    li t1, 35
    sra t2, t0, t1
    //prgchk reg t2 == 0xf95fd757f95fda01
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffbd5b7dd
    li t1, 36
    sra t2, t0, t1
    //prgchk reg t2 == 0xfcafebabfcafed00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffdeadbee
    li t1, 37
    sra t2, t0, t1
    //prgchk reg t2 == 0x7e57f5d5fe57f680
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffef56df7
    li t1, 38
    sra t2, t0, t1
    //prgchk reg t2 == 0xbf2bfaeaff2bfb40
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffff7ab6fb
    li t1, 39
    sra t2, t0, t1
    //prgchk reg t2 == 0xdf95fd757f95fda0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffbd5b7d
    li t1, 40
    sra t2, t0, t1
    //prgchk reg t2 == 0xefcafebabfcafed0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffdeadbe
    li t1, 41
    sra t2, t0, t1
    //prgchk reg t2 == 0x77e57f5d5fe57f68
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffef56df
    li t1, 42
    sra t2, t0, t1
    //prgchk reg t2 == 0xbbf2bfaeaff2bfb4
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffff7ab6f
    li t1, 43
    sra t2, t0, t1
    //prgchk reg t2 == 0xddf95fd757f95fda
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffbd5b7
    li t1, 44
    sra t2, t0, t1
    //prgchk reg t2 == 0xeefcafebabfcafed
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffdeadb
    li t1, 45
    sra t2, t0, t1
    //prgchk reg t2 == 0xf77e57f5d5fe57f6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffef56d
    li t1, 46
    sra t2, t0, t1
    //prgchk reg t2 == 0xfbbf2bfaeaff2bfb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffff7ab6
    li t1, 47
    sra t2, t0, t1
    //prgchk reg t2 == 0x7ddf95fd757f95fd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffbd5b
    li t1, 48
    sra t2, t0, t1
    //prgchk reg t2 == 0xbeefcafebabfcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffdead
    li t1, 49
    sra t2, t0, t1
    //prgchk reg t2 == 0xdf77e57f5d5fe57f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffef56
    li t1, 50
    sra t2, t0, t1
    //prgchk reg t2 == 0x6fbbf2bfaeaff2bf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffff7ab
    li t1, 51
    sra t2, t0, t1
    //prgchk reg t2 == 0xb7ddf95fd757f95f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffffbd5
    li t1, 52
    sra t2, t0, t1
    //prgchk reg t2 == 0xdbeefcafebabfcaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffffdea
    li t1, 53
    sra t2, t0, t1
    //prgchk reg t2 == 0x6df77e57f5d5fe57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffffef5
    li t1, 54
    sra t2, t0, t1
    //prgchk reg t2 == 0xb6fbbf2bfaeaff2b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffff7a
    li t1, 55
    sra t2, t0, t1
    //prgchk reg t2 == 0x5b7ddf95fd757f95
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffbd
    li t1, 56
    sra t2, t0, t1
    //prgchk reg t2 == 0xadbeefcafebabfca
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffde
    li t1, 57
    sra t2, t0, t1
    //prgchk reg t2 == 0x56df77e57f5d5fe5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffef
    li t1, 58
    sra t2, t0, t1
    //prgchk reg t2 == 0xab6fbbf2bfaeaff2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffffff7
    li t1, 59
    sra t2, t0, t1
    //prgchk reg t2 == 0xd5b7ddf95fd757f9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffffffb
    li t1, 60
    sra t2, t0, t1
    //prgchk reg t2 == 0xeadbeefcafebabfc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffffffd
    li t1, 61
    sra t2, t0, t1
    //prgchk reg t2 == 0xf56df77e57f5d5fe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffffffffe
    li t1, 62
    sra t2, t0, t1
    //prgchk reg t2 == 0x7ab6fbbf2bfaeaff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 63
    sra t2, t0, t1
    //prgchk reg t2 == 0xbd5b7ddf95fd757f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 64
    sra t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 65
    sra t2, t0, t1
    //prgchk reg t2 == 0xef56df77e57f5d5f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 66
    sra t2, t0, t1
    //prgchk reg t2 == 0xf7ab6fbbf2bfaeaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 67
    sra t2, t0, t1
    //prgchk reg t2 == 0xfbd5b7ddf95fd757
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 68
    sra t2, t0, t1
    //prgchk reg t2 == 0xfdeadbeefcafebab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 69
    sra t2, t0, t1
    //prgchk reg t2 == 0xfef56df77e57f5d5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 70
    sra t2, t0, t1
    //prgchk reg t2 == 0xff7ab6fbbf2bfaea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 71
    sra t2, t0, t1
    //prgchk reg t2 == 0xffbd5b7ddf95fd75
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 72
    sra t2, t0, t1
    //prgchk reg t2 == 0xffdeadbeefcafeba
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 73
    sra t2, t0, t1
    //prgchk reg t2 == 0xffef56df77e57f5d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 74
    sra t2, t0, t1
    //prgchk reg t2 == 0xfff7ab6fbbf2bfae
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 75
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffbd5b7ddf95fd7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 76
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffdeadbeefcafeb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 77
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffef56df77e57f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 78
    sra t2, t0, t1
    //prgchk reg t2 == 0xffff7ab6fbbf2bfa
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 79
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffbd5b7ddf95fd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 80
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffdeadbeefcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 81
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffef56df77e57f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 82
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffff7ab6fbbf2bf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 83
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffbd5b7ddf95f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 84
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffdeadbeefcaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 85
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffef56df77e57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 86
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffff7ab6fbbf2b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 87
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffbd5b7ddf95
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 88
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffdeadbeefca
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 89
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffef56df77e5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 90
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffff7ab6fbbf2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 91
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffbd5b7ddf9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 92
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffdeadbeefc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 93
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffef56df77e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 94
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffff7ab6fbbf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 95
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffbd5b7ddf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 96
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 97
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffef56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 98
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffff7ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 99
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffbd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 100
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 101
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffef56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 102
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffff7ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 103
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffbd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 104
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 105
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffef56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 106
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffff7ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 107
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffbd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 108
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 109
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffef56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 110
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffff7ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 111
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffbd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 112
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 113
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 114
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffff7ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 115
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 116
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 117
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 118
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffff7a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 119
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 120
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 121
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 122
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffff7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 123
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 124
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 125
    sra t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 126
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 127
    sra t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

j exit