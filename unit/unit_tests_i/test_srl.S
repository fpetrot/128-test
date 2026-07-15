#include "exit.S"


.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, -1
    //prgchk reg s0 == 0xffffffffffffffffffffffffffffffff

    li s1, 32
    srl s2, s0, s1
    //prgchk reg s2 == 0x00000000ffffffffffffffffffffffff

    li s0, 0xffffffffffffffff
    //prgchk reg s0 == 0xffffffffffffffff
    li s1, 64
    srl s2, s0, s1
    //prgchk reg s2 == 0x0000000000000000

    li s1, 32
    srl s2, s0, s1
    //prgchk reg s2 == 0xffffffff

    li s1, 0
    srl s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffff

    // Check non-carry of sign bit (logical shift)
    li s0, 0x80000000000000000000000000000000
    li s6, 127
    srl s2, s0, s6
    //prgchk reg s2 == 1

    // Incremental shifts
    li s0, 0xdeadbeefcafebabfcafed00ddeaddead
    li s1, 0
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00ddeaddead

    li s1, 1
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806ef56ef56

    li s1, 2
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb40377ab77ab

    li s1, 3
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01bbd5bbd5

    li s1, 4
    srl s2, s0, s1
    //prgchk reg s2 == 0x0deadbeefcafebabfcafed00ddeaddea

    li s1, 5
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806ef56ef5

    li s1, 6
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb40377ab77a

    li s1, 7
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01bbd5bbd

    li s1, 8
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00ddeadde

    li s1, 9
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806ef56ef

    li s1, 10
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb40377ab77

    li s1, 11
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01bbd5bb

    li s1, 12
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00ddeadd

    li s1, 13
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806ef56e

    li s1, 14
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb40377ab7

    li s1, 15
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01bbd5b

    li s1, 16
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00ddead

    li s1, 17
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806ef56

    li s1, 18
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb40377ab

    li s1, 19
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01bbd5

    li s1, 20
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00ddea

    li s1, 21
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806ef5

    li s1, 22
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb40377a

    li s1, 23
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01bbd

    li s1, 24
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00dde

    li s1, 25
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806ef

    li s1, 26
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb40377

    li s1, 27
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01bb

    li s1, 28
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00dd

    li s1, 29
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806e

    li s1, 30
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb4037

    li s1, 31
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01b

    li s1, 32
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00d

    li s1, 33
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6806

    li s1, 34
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb403

    li s1, 35
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda01

    li s1, 36
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00

    li s1, 37
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f680

    li s1, 38
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb40

    li s1, 39
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda0

    li s1, 40
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed0

    li s1, 41
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f68

    li s1, 42
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb4

    li s1, 43
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fda

    li s1, 44
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed

    li s1, 45
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f6

    li s1, 46
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bfb

    li s1, 47
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95fd

    li s1, 48
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafe

    li s1, 49
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57f

    li s1, 50
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2bf

    li s1, 51
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95f

    li s1, 52
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcaf

    li s1, 53
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe57

    li s1, 54
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2b

    li s1, 55
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f95

    li s1, 56
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfca

    li s1, 57
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe5

    li s1, 58
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff2

    li s1, 59
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f9

    li s1, 60
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfc

    li s1, 61
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5fe

    li s1, 62
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaff

    li s1, 63
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757f

    li s1, 64
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabf

    li s1, 65
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5f

    li s1, 66
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaeaf

    li s1, 67
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd757

    li s1, 68
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebab

    li s1, 69
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d5

    li s1, 70
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfaea

    li s1, 71
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd75

    li s1, 72
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafeba

    li s1, 73
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5d

    li s1, 74
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfae

    li s1, 75
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd7

    li s1, 76
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafeb

    li s1, 77
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f5

    li s1, 78
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bfa

    li s1, 79
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95fd

    li s1, 80
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafe

    li s1, 81
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57f

    li s1, 82
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2bf

    li s1, 83
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95f

    li s1, 84
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcaf

    li s1, 85
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e57

    li s1, 86
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2b

    li s1, 87
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf95

    li s1, 88
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefca

    li s1, 89
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e5

    li s1, 90
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf2

    li s1, 91
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf9

    li s1, 92
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefc

    li s1, 93
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77e

    li s1, 94
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbbf

    li s1, 95
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7ddf

    li s1, 96
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbeef

    li s1, 97
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df77

    li s1, 98
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fbb

    li s1, 99
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7dd

    li s1, 100
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbee

    li s1, 101
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df7

    li s1, 102
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6fb

    li s1, 103
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7d

    li s1, 104
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadbe

    li s1, 105
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56df

    li s1, 106
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6f

    li s1, 107
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b7

    li s1, 108
    srl s2, s0, s1
    //prgchk reg s2 == 0xdeadb

    li s1, 109
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56d

    li s1, 110
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab6

    li s1, 111
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5b

    li s1, 112
    srl s2, s0, s1
    //prgchk reg s2 == 0xdead

    li s1, 113
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f56

    li s1, 114
    srl s2, s0, s1
    //prgchk reg s2 == 0x37ab

    li s1, 115
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd5

    li s1, 116
    srl s2, s0, s1
    //prgchk reg s2 == 0xdea

    li s1, 117
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f5

    li s1, 118
    srl s2, s0, s1
    //prgchk reg s2 == 0x37a

    li s1, 119
    srl s2, s0, s1
    //prgchk reg s2 == 0x1bd

    li s1, 120
    srl s2, s0, s1
    //prgchk reg s2 == 0xde

    li s1, 121
    srl s2, s0, s1
    //prgchk reg s2 == 0x6f

    li s1, 122
    srl s2, s0, s1
    //prgchk reg s2 == 0x37

    li s1, 123
    srl s2, s0, s1
    //prgchk reg s2 == 0x1b

    li s1, 124
    srl s2, s0, s1
    //prgchk reg s2 == 0xd

    li s1, 125
    srl s2, s0, s1
    //prgchk reg s2 == 0x6

    li s1, 126
    srl s2, s0, s1
    //prgchk reg s2 == 0x3

    li s1, 127
    srl s2, s0, s1
    //prgchk reg s2 == 0x1


    j exit
