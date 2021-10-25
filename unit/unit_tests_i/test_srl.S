#include "insns.S" 
#include "utils.S"


.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    li t0, 0xffffffffffffffff
    srli(t2, t0, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    li t1, 32
    srl t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffff

    liu(t0, 0xffffffffffffffff)
    //prgchk reg t0 == 0xffffffffffffffff
    srli(t2, t0, 64)
    //prgchk reg t2 == 0x0000000000000000

    li t1, 32
    srl t2, t0, t1
    //prgchk reg t2 == 0xffffffff

    li t1, 0
    srl t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff

    // Check non-carry of sign bit (logical shift)
    li t0, 0x8000000000000000
    slli(t1, t0, 64)
    li t6, 127
    srl t2, t1, t6
    //prgchk reg t2 == 1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Incremental shifts
    liu(t0, 0xdeadbeefcafebabf)
    slli(t0, t0, 64)
    liu(t1, 0xcafed00ddeaddead)
    or t0, t0, t1
    li t1, 0
    srl t2, t0, t1
    //prgchk reg t2 == 0xcafed00ddeaddead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefcafebabf
    li t1, 1
    srl t2, t0, t1
    //prgchk reg t2 == 0xe57f6806ef56ef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77e57f5d5f
    li t1, 2
    srl t2, t0, t1
    //prgchk reg t2 == 0xf2bfb40377ab77ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaf
    li t1, 3
    srl t2, t0, t1
    //prgchk reg t2 == 0xf95fda01bbd5bbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7ddf95fd757
    li t1, 4
    srl t2, t0, t1
    //prgchk reg t2 == 0xfcafed00ddeaddea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefcafebab
    li t1, 5
    srl t2, t0, t1
    //prgchk reg t2 == 0xfe57f6806ef56ef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77e57f5d5
    li t1, 6
    srl t2, t0, t1
    //prgchk reg t2 == 0xff2bfb40377ab77a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbbf2bfaea
    li t1, 7
    srl t2, t0, t1
    //prgchk reg t2 == 0x7f95fda01bbd5bbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7ddf95fd75
    li t1, 8
    srl t2, t0, t1
    //prgchk reg t2 == 0xbfcafed00ddeadde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefcafeba
    li t1, 9
    srl t2, t0, t1
    //prgchk reg t2 == 0x5fe57f6806ef56ef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77e57f5d
    li t1, 10
    srl t2, t0, t1
    //prgchk reg t2 == 0xaff2bfb40377ab77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbbf2bfae
    li t1, 11
    srl t2, t0, t1
    //prgchk reg t2 == 0x57f95fda01bbd5bb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7ddf95fd7
    li t1, 12
    srl t2, t0, t1
    //prgchk reg t2 == 0xabfcafed00ddeadd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefcafeb
    li t1, 13
    srl t2, t0, t1
    //prgchk reg t2 == 0xd5fe57f6806ef56e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77e57f5
    li t1, 14
    srl t2, t0, t1
    //prgchk reg t2 == 0xeaff2bfb40377ab7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbbf2bfa
    li t1, 15
    srl t2, t0, t1
    //prgchk reg t2 == 0x757f95fda01bbd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7ddf95fd
    li t1, 16
    srl t2, t0, t1
    //prgchk reg t2 == 0xbabfcafed00ddead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefcafe
    li t1, 17
    srl t2, t0, t1
    //prgchk reg t2 == 0x5d5fe57f6806ef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77e57f
    li t1, 18
    srl t2, t0, t1
    //prgchk reg t2 == 0xaeaff2bfb40377ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbbf2bf
    li t1, 19
    srl t2, t0, t1
    //prgchk reg t2 == 0xd757f95fda01bbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7ddf95f
    li t1, 20
    srl t2, t0, t1
    //prgchk reg t2 == 0xebabfcafed00ddea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefcaf
    li t1, 21
    srl t2, t0, t1
    //prgchk reg t2 == 0xf5d5fe57f6806ef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77e57
    li t1, 22
    srl t2, t0, t1
    //prgchk reg t2 == 0xfaeaff2bfb40377a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbbf2b
    li t1, 23
    srl t2, t0, t1
    //prgchk reg t2 == 0xfd757f95fda01bbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7ddf95
    li t1, 24
    srl t2, t0, t1
    //prgchk reg t2 == 0xfebabfcafed00dde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefca
    li t1, 25
    srl t2, t0, t1
    //prgchk reg t2 == 0x7f5d5fe57f6806ef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77e5
    li t1, 26
    srl t2, t0, t1
    //prgchk reg t2 == 0xbfaeaff2bfb40377
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbbf2
    li t1, 27
    srl t2, t0, t1
    //prgchk reg t2 == 0x5fd757f95fda01bb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7ddf9
    li t1, 28
    srl t2, t0, t1
    //prgchk reg t2 == 0xafebabfcafed00dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefc
    li t1, 29
    srl t2, t0, t1
    //prgchk reg t2 == 0x57f5d5fe57f6806e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77e
    li t1, 30
    srl t2, t0, t1
    //prgchk reg t2 == 0x2bfaeaff2bfb4037
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbbf
    li t1, 31
    srl t2, t0, t1
    //prgchk reg t2 == 0x95fd757f95fda01b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7ddf
    li t1, 32
    srl t2, t0, t1
    //prgchk reg t2 == 0xcafebabfcafed00d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeef
    li t1, 33
    srl t2, t0, t1
    //prgchk reg t2 == 0xe57f5d5fe57f6806
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df77
    li t1, 34
    srl t2, t0, t1
    //prgchk reg t2 == 0xf2bfaeaff2bfb403
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fbb
    li t1, 35
    srl t2, t0, t1
    //prgchk reg t2 == 0xf95fd757f95fda01
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7dd
    li t1, 36
    srl t2, t0, t1
    //prgchk reg t2 == 0xfcafebabfcafed00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbee
    li t1, 37
    srl t2, t0, t1
    //prgchk reg t2 == 0x7e57f5d5fe57f680
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df7
    li t1, 38
    srl t2, t0, t1
    //prgchk reg t2 == 0xbf2bfaeaff2bfb40
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6fb
    li t1, 39
    srl t2, t0, t1
    //prgchk reg t2 == 0xdf95fd757f95fda0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7d
    li t1, 40
    srl t2, t0, t1
    //prgchk reg t2 == 0xefcafebabfcafed0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbe
    li t1, 41
    srl t2, t0, t1
    //prgchk reg t2 == 0x77e57f5d5fe57f68
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56df
    li t1, 42
    srl t2, t0, t1
    //prgchk reg t2 == 0xbbf2bfaeaff2bfb4
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6f
    li t1, 43
    srl t2, t0, t1
    //prgchk reg t2 == 0xddf95fd757f95fda
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b7
    li t1, 44
    srl t2, t0, t1
    //prgchk reg t2 == 0xeefcafebabfcafed
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadb
    li t1, 45
    srl t2, t0, t1
    //prgchk reg t2 == 0xf77e57f5d5fe57f6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56d
    li t1, 46
    srl t2, t0, t1
    //prgchk reg t2 == 0xfbbf2bfaeaff2bfb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab6
    li t1, 47
    srl t2, t0, t1
    //prgchk reg t2 == 0x7ddf95fd757f95fd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5b
    li t1, 48
    srl t2, t0, t1
    //prgchk reg t2 == 0xbeefcafebabfcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdead
    li t1, 49
    srl t2, t0, t1
    //prgchk reg t2 == 0xdf77e57f5d5fe57f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f56
    li t1, 50
    srl t2, t0, t1
    //prgchk reg t2 == 0x6fbbf2bfaeaff2bf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37ab
    li t1, 51
    srl t2, t0, t1
    //prgchk reg t2 == 0xb7ddf95fd757f95f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd5
    li t1, 52
    srl t2, t0, t1
    //prgchk reg t2 == 0xdbeefcafebabfcaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdea
    li t1, 53
    srl t2, t0, t1
    //prgchk reg t2 == 0x6df77e57f5d5fe57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f5
    li t1, 54
    srl t2, t0, t1
    //prgchk reg t2 == 0xb6fbbf2bfaeaff2b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37a
    li t1, 55
    srl t2, t0, t1
    //prgchk reg t2 == 0x5b7ddf95fd757f95
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bd
    li t1, 56
    srl t2, t0, t1
    //prgchk reg t2 == 0xadbeefcafebabfca
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xde
    li t1, 57
    srl t2, t0, t1
    //prgchk reg t2 == 0x56df77e57f5d5fe5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6f
    li t1, 58
    srl t2, t0, t1
    //prgchk reg t2 == 0xab6fbbf2bfaeaff2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x37
    li t1, 59
    srl t2, t0, t1
    //prgchk reg t2 == 0xd5b7ddf95fd757f9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1b
    li t1, 60
    srl t2, t0, t1
    //prgchk reg t2 == 0xeadbeefcafebabfc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xd
    li t1, 61
    srl t2, t0, t1
    //prgchk reg t2 == 0xf56df77e57f5d5fe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6
    li t1, 62
    srl t2, t0, t1
    //prgchk reg t2 == 0x7ab6fbbf2bfaeaff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x3
    li t1, 63
    srl t2, t0, t1
    //prgchk reg t2 == 0xbd5b7ddf95fd757f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1
    li t1, 64
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 65
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 66
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 67
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 68
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 69
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 70
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 71
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd75
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 72
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafeba
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 73
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 74
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfae
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 75
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 76
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafeb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 77
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 78
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfa
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 79
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 80
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 81
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 82
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 83
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 84
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcaf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 85
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 86
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 87
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 88
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefca
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 89
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 90
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 91
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 92
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 93
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 94
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 95
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 96
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 97
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 98
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 99
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 100
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 101
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 102
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 103
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 104
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 105
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 106
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 107
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 108
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 109
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 110
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 111
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 112
    srl t2, t0, t1
    //prgchk reg t2 == 0xdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 113
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 114
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 115
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 116
    srl t2, t0, t1
    //prgchk reg t2 == 0xdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 117
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 118
    srl t2, t0, t1
    //prgchk reg t2 == 0x37a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 119
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 120
    srl t2, t0, t1
    //prgchk reg t2 == 0xde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 121
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 122
    srl t2, t0, t1
    //prgchk reg t2 == 0x37
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 123
    srl t2, t0, t1
    //prgchk reg t2 == 0x1b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 124
    srl t2, t0, t1
    //prgchk reg t2 == 0xd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 125
    srl t2, t0, t1
    //prgchk reg t2 == 0x6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 126
    srl t2, t0, t1
    //prgchk reg t2 == 0x3
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 127
    srl t2, t0, t1
    //prgchk reg t2 == 0x1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0

j exit
