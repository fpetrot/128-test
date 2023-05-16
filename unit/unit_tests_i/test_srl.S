#include "exit.S"


.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, -1
    //prgchk reg t0 == 0xffffffffffffffffffffffffffffffff

    li t1, 32
    srl t2, t0, t1
    //prgchk reg t2 == 0x00000000ffffffffffffffffffffffff

    li t0, 0xffffffffffffffff
    //prgchk reg t0 == 0xffffffffffffffff
    li t1, 64
    srl t2, t0, t1
    //prgchk reg t2 == 0x0000000000000000

    li t1, 32
    srl t2, t0, t1
    //prgchk reg t2 == 0xffffffff

    li t1, 0
    srl t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff

    // Check non-carry of sign bit (logical shift)
    li t0, 0x80000000000000000000000000000000
    li t6, 127
    srl t2, t0, t6
    //prgchk reg t2 == 1

    // Incremental shifts
    li t0, 0xdeadbeefcafebabfcafed00ddeaddead
    li t1, 0
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00ddeaddead

    li t1, 1
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806ef56ef56

    li t1, 2
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb40377ab77ab

    li t1, 3
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01bbd5bbd5

    li t1, 4
    srl t2, t0, t1
    //prgchk reg t2 == 0x0deadbeefcafebabfcafed00ddeaddea

    li t1, 5
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806ef56ef5

    li t1, 6
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb40377ab77a

    li t1, 7
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01bbd5bbd

    li t1, 8
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00ddeadde

    li t1, 9
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806ef56ef

    li t1, 10
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb40377ab77

    li t1, 11
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01bbd5bb

    li t1, 12
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00ddeadd

    li t1, 13
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806ef56e

    li t1, 14
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb40377ab7

    li t1, 15
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01bbd5b

    li t1, 16
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00ddead

    li t1, 17
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806ef56

    li t1, 18
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb40377ab

    li t1, 19
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01bbd5

    li t1, 20
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00ddea

    li t1, 21
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806ef5

    li t1, 22
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb40377a

    li t1, 23
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01bbd

    li t1, 24
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00dde

    li t1, 25
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806ef

    li t1, 26
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb40377

    li t1, 27
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01bb

    li t1, 28
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00dd

    li t1, 29
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806e

    li t1, 30
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb4037

    li t1, 31
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01b

    li t1, 32
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00d

    li t1, 33
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6806

    li t1, 34
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb403

    li t1, 35
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda01

    li t1, 36
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed00

    li t1, 37
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f680

    li t1, 38
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb40

    li t1, 39
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda0

    li t1, 40
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed0

    li t1, 41
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f68

    li t1, 42
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb4

    li t1, 43
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fda

    li t1, 44
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafed

    li t1, 45
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f6

    li t1, 46
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bfb

    li t1, 47
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95fd

    li t1, 48
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcafe

    li t1, 49
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57f

    li t1, 50
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2bf

    li t1, 51
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95f

    li t1, 52
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfcaf

    li t1, 53
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe57

    li t1, 54
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2b

    li t1, 55
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f95

    li t1, 56
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfca

    li t1, 57
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe5

    li t1, 58
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff2

    li t1, 59
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f9

    li t1, 60
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabfc

    li t1, 61
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5fe

    li t1, 62
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaff

    li t1, 63
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757f

    li t1, 64
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebabf

    li t1, 65
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5f

    li t1, 66
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaeaf

    li t1, 67
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd757

    li t1, 68
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafebab

    li t1, 69
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d5

    li t1, 70
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfaea

    li t1, 71
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd75

    li t1, 72
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafeba

    li t1, 73
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5d

    li t1, 74
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfae

    li t1, 75
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd7

    li t1, 76
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafeb

    li t1, 77
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f5

    li t1, 78
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bfa

    li t1, 79
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95fd

    li t1, 80
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcafe

    li t1, 81
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57f

    li t1, 82
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2bf

    li t1, 83
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95f

    li t1, 84
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefcaf

    li t1, 85
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e57

    li t1, 86
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2b

    li t1, 87
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf95

    li t1, 88
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefca

    li t1, 89
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e5

    li t1, 90
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf2

    li t1, 91
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf9

    li t1, 92
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeefc

    li t1, 93
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77e

    li t1, 94
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbbf

    li t1, 95
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7ddf

    li t1, 96
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbeef

    li t1, 97
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df77

    li t1, 98
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbb

    li t1, 99
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7dd

    li t1, 100
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbee

    li t1, 101
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df7

    li t1, 102
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6fb

    li t1, 103
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7d

    li t1, 104
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadbe

    li t1, 105
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56df

    li t1, 106
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6f

    li t1, 107
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7

    li t1, 108
    srl t2, t0, t1
    //prgchk reg t2 == 0xdeadb

    li t1, 109
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56d

    li t1, 110
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab6

    li t1, 111
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5b

    li t1, 112
    srl t2, t0, t1
    //prgchk reg t2 == 0xdead

    li t1, 113
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f56

    li t1, 114
    srl t2, t0, t1
    //prgchk reg t2 == 0x37ab

    li t1, 115
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd5

    li t1, 116
    srl t2, t0, t1
    //prgchk reg t2 == 0xdea

    li t1, 117
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f5

    li t1, 118
    srl t2, t0, t1
    //prgchk reg t2 == 0x37a

    li t1, 119
    srl t2, t0, t1
    //prgchk reg t2 == 0x1bd

    li t1, 120
    srl t2, t0, t1
    //prgchk reg t2 == 0xde

    li t1, 121
    srl t2, t0, t1
    //prgchk reg t2 == 0x6f

    li t1, 122
    srl t2, t0, t1
    //prgchk reg t2 == 0x37

    li t1, 123
    srl t2, t0, t1
    //prgchk reg t2 == 0x1b

    li t1, 124
    srl t2, t0, t1
    //prgchk reg t2 == 0xd

    li t1, 125
    srl t2, t0, t1
    //prgchk reg t2 == 0x6

    li t1, 126
    srl t2, t0, t1
    //prgchk reg t2 == 0x3

    li t1, 127
    srl t2, t0, t1
    //prgchk reg t2 == 0x1


    j exit
