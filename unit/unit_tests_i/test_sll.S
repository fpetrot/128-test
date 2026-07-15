#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0xffffffffffffffff
    //prgchk reg s0 == 0xffffffffffffffff
    li s1, 32
    //prgchk reg s1 == 32

    li s2, 0xffffffffffffffff
    //prgchk reg s2 == 0xffffffffffffffff
    sll s2, s0, s1
    //prgchk reg s2 == 0x00000000ffffffffffffffff00000000

    // Shift by zero
    lui s0, 0
    //progchk reg s0 == 0
    li s1, 0xdeadbeefcafebabf
    //prgchk reg s1 == 0xdeadbeefcafebabf
    sll s2, s1, s0
    //prgchk reg s2 == 0xdeadbeefcafebabf

    // Shift by max shift
    li s0, 127
    //prgchk reg s0 == 127
    sll s2, s1, s0
    //prgchk reg s2 == 0x80000000000000000000000000000000

    // Incremental shifts
    li s0, 0xdeadbeefcafebabf0000000000000000
    li s1, 0xcafed00ddeaddead
    or s0, s0, s1
    li s1, 0
    sll s2, s0, s1
    //prgchk reg s2 == 0xdeadbeefcafebabfcafed00ddeaddead
    li s1, 1
    sll s2, s0, s1
    //prgchk reg s2 == 0xbd5b7ddf95fd757f95fda01bbd5bbd5a
    li s1, 2
    sll s2, s0, s1
    //prgchk reg s2 == 0x7ab6fbbf2bfaeaff2bfb40377ab77ab4
    li s1, 3
    sll s2, s0, s1
    //prgchk reg s2 == 0xf56df77e57f5d5fe57f6806ef56ef568
    li s1, 4
    sll s2, s0, s1
    //prgchk reg s2 == 0xeadbeefcafebabfcafed00ddeaddead0
    li s1, 5
    sll s2, s0, s1
    //prgchk reg s2 == 0xd5b7ddf95fd757f95fda01bbd5bbd5a0
    li s1, 6
    sll s2, s0, s1
    //prgchk reg s2 == 0xab6fbbf2bfaeaff2bfb40377ab77ab40
    li s1, 7
    sll s2, s0, s1
    //prgchk reg s2 == 0x56df77e57f5d5fe57f6806ef56ef5680
    li s1, 8
    sll s2, s0, s1
    //prgchk reg s2 == 0xadbeefcafebabfcafed00ddeaddead00
    li s1, 9
    sll s2, s0, s1
    //prgchk reg s2 == 0x5b7ddf95fd757f95fda01bbd5bbd5a00
    li s1, 10
    sll s2, s0, s1
    //prgchk reg s2 == 0xb6fbbf2bfaeaff2bfb40377ab77ab400
    li s1, 11
    sll s2, s0, s1
    //prgchk reg s2 == 0x6df77e57f5d5fe57f6806ef56ef56800
    li s1, 12
    sll s2, s0, s1
    //prgchk reg s2 == 0xdbeefcafebabfcafed00ddeaddead000
    li s1, 13
    sll s2, s0, s1
    //prgchk reg s2 == 0xb7ddf95fd757f95fda01bbd5bbd5a000
    li s1, 14
    sll s2, s0, s1
    //prgchk reg s2 == 0x6fbbf2bfaeaff2bfb40377ab77ab4000
    li s1, 15
    sll s2, s0, s1
    //prgchk reg s2 == 0xdf77e57f5d5fe57f6806ef56ef568000
    li s1, 16
    sll s2, s0, s1
    //prgchk reg s2 == 0xbeefcafebabfcafed00ddeaddead0000
    li s1, 17
    sll s2, s0, s1
    //prgchk reg s2 == 0x7ddf95fd757f95fda01bbd5bbd5a0000
    li s1, 18
    sll s2, s0, s1
    //prgchk reg s2 == 0xfbbf2bfaeaff2bfb40377ab77ab40000
    li s1, 19
    sll s2, s0, s1
    //prgchk reg s2 == 0xf77e57f5d5fe57f6806ef56ef5680000
    li s1, 20
    sll s2, s0, s1
    //prgchk reg s2 == 0xeefcafebabfcafed00ddeaddead00000
    li s1, 21
    sll s2, s0, s1
    //prgchk reg s2 == 0xddf95fd757f95fda01bbd5bbd5a00000
    li s1, 22
    sll s2, s0, s1
    //prgchk reg s2 == 0xbbf2bfaeaff2bfb40377ab77ab400000
    li s1, 23
    sll s2, s0, s1
    //prgchk reg s2 == 0x77e57f5d5fe57f6806ef56ef56800000
    li s1, 24
    sll s2, s0, s1
    //prgchk reg s2 == 0xefcafebabfcafed00ddeaddead000000
    li s1, 25
    sll s2, s0, s1
    //prgchk reg s2 == 0xdf95fd757f95fda01bbd5bbd5a000000
    li s1, 26
    sll s2, s0, s1
    //prgchk reg s2 == 0xbf2bfaeaff2bfb40377ab77ab4000000
    li s1, 27
    sll s2, s0, s1
    //prgchk reg s2 == 0x7e57f5d5fe57f6806ef56ef568000000
    li s1, 28
    sll s2, s0, s1
    //prgchk reg s2 == 0xfcafebabfcafed00ddeaddead0000000
    li s1, 29
    sll s2, s0, s1
    //prgchk reg s2 == 0xf95fd757f95fda01bbd5bbd5a0000000
    li s1, 30
    sll s2, s0, s1
    //prgchk reg s2 == 0xf2bfaeaff2bfb40377ab77ab40000000
    li s1, 31
    sll s2, s0, s1
    //prgchk reg s2 == 0xe57f5d5fe57f6806ef56ef5680000000
    li s1, 32
    sll s2, s0, s1
    //prgchk reg s2 == 0xcafebabfcafed00ddeaddead00000000
    li s1, 33
    sll s2, s0, s1
    //prgchk reg s2 == 0x95fd757f95fda01bbd5bbd5a00000000
    li s1, 34
    sll s2, s0, s1
    //prgchk reg s2 == 0x2bfaeaff2bfb40377ab77ab400000000
    li s1, 35
    sll s2, s0, s1
    //prgchk reg s2 == 0x57f5d5fe57f6806ef56ef56800000000
    li s1, 36
    sll s2, s0, s1
    //prgchk reg s2 == 0xafebabfcafed00ddeaddead000000000
    li s1, 37
    sll s2, s0, s1
    //prgchk reg s2 == 0x5fd757f95fda01bbd5bbd5a000000000
    li s1, 38
    sll s2, s0, s1
    //prgchk reg s2 == 0xbfaeaff2bfb40377ab77ab4000000000
    li s1, 39
    sll s2, s0, s1
    //prgchk reg s2 == 0x7f5d5fe57f6806ef56ef568000000000
    li s1, 40
    sll s2, s0, s1
    //prgchk reg s2 == 0xfebabfcafed00ddeaddead0000000000
    li s1, 41
    sll s2, s0, s1
    //prgchk reg s2 == 0xfd757f95fda01bbd5bbd5a0000000000
    li s1, 42
    sll s2, s0, s1
    //prgchk reg s2 == 0xfaeaff2bfb40377ab77ab40000000000
    li s1, 43
    sll s2, s0, s1
    //prgchk reg s2 == 0xf5d5fe57f6806ef56ef5680000000000
    li s1, 44
    sll s2, s0, s1
    //prgchk reg s2 == 0xebabfcafed00ddeaddead00000000000
    li s1, 45
    sll s2, s0, s1
    //prgchk reg s2 == 0xd757f95fda01bbd5bbd5a00000000000
    li s1, 46
    sll s2, s0, s1
    //prgchk reg s2 == 0xaeaff2bfb40377ab77ab400000000000
    li s1, 47
    sll s2, s0, s1
    //prgchk reg s2 == 0x5d5fe57f6806ef56ef56800000000000
    li s1, 48
    sll s2, s0, s1
    //prgchk reg s2 == 0xbabfcafed00ddeaddead000000000000
    li s1, 49
    sll s2, s0, s1
    //prgchk reg s2 == 0x757f95fda01bbd5bbd5a000000000000
    li s1, 50
    sll s2, s0, s1
    //prgchk reg s2 == 0xeaff2bfb40377ab77ab4000000000000
    li s1, 51
    sll s2, s0, s1
    //prgchk reg s2 == 0xd5fe57f6806ef56ef568000000000000
    li s1, 52
    sll s2, s0, s1
    //prgchk reg s2 == 0xabfcafed00ddeaddead0000000000000
    li s1, 53
    sll s2, s0, s1
    //prgchk reg s2 == 0x57f95fda01bbd5bbd5a0000000000000
    li s1, 54
    sll s2, s0, s1
    //prgchk reg s2 == 0xaff2bfb40377ab77ab40000000000000
    li s1, 55
    sll s2, s0, s1
    //prgchk reg s2 == 0x5fe57f6806ef56ef5680000000000000
    li s1, 56
    sll s2, s0, s1
    //prgchk reg s2 == 0xbfcafed00ddeaddead00000000000000
    li s1, 57
    sll s2, s0, s1
    //prgchk reg s2 == 0x7f95fda01bbd5bbd5a00000000000000
    li s1, 58
    sll s2, s0, s1
    //prgchk reg s2 == 0xff2bfb40377ab77ab400000000000000
    li s1, 59
    sll s2, s0, s1
    //prgchk reg s2 == 0xfe57f6806ef56ef56800000000000000
    li s1, 60
    sll s2, s0, s1
    //prgchk reg s2 == 0xfcafed00ddeaddead000000000000000
    li s1, 61
    sll s2, s0, s1
    //prgchk reg s2 == 0xf95fda01bbd5bbd5a000000000000000
    li s1, 62
    sll s2, s0, s1
    //prgchk reg s2 == 0xf2bfb40377ab77ab4000000000000000
    li s1, 63
    sll s2, s0, s1
    //prgchk reg s2 == 0xe57f6806ef56ef568000000000000000
    li s1, 64
    sll s2, s0, s1
    //prgchk reg s2 == 0xcafed00ddeaddead0000000000000000
    li s1, 65
    sll s2, s0, s1
    //prgchk reg s2 == 0x95fda01bbd5bbd5a0000000000000000
    li s1, 66
    sll s2, s0, s1
    //prgchk reg s2 == 0x2bfb40377ab77ab40000000000000000
    li s1, 67
    sll s2, s0, s1
    //prgchk reg s2 == 0x57f6806ef56ef5680000000000000000
    li s1, 68
    sll s2, s0, s1
    //prgchk reg s2 == 0xafed00ddeaddead00000000000000000
    li s1, 69
    sll s2, s0, s1
    //prgchk reg s2 == 0x5fda01bbd5bbd5a00000000000000000
    li s1, 70
    sll s2, s0, s1
    //prgchk reg s2 == 0xbfb40377ab77ab400000000000000000
    li s1, 71
    sll s2, s0, s1
    //prgchk reg s2 == 0x7f6806ef56ef56800000000000000000
    li s1, 72
    sll s2, s0, s1
    //prgchk reg s2 == 0xfed00ddeaddead000000000000000000
    li s1, 73
    sll s2, s0, s1
    //prgchk reg s2 == 0xfda01bbd5bbd5a000000000000000000
    li s1, 74
    sll s2, s0, s1
    //prgchk reg s2 == 0xfb40377ab77ab4000000000000000000
    li s1, 75
    sll s2, s0, s1
    //prgchk reg s2 == 0xf6806ef56ef568000000000000000000
    li s1, 76
    sll s2, s0, s1
    //prgchk reg s2 == 0xed00ddeaddead0000000000000000000
    li s1, 77
    sll s2, s0, s1
    //prgchk reg s2 == 0xda01bbd5bbd5a0000000000000000000
    li s1, 78
    sll s2, s0, s1
    //prgchk reg s2 == 0xb40377ab77ab40000000000000000000
    li s1, 79
    sll s2, s0, s1
    //prgchk reg s2 == 0x6806ef56ef5680000000000000000000
    li s1, 80
    sll s2, s0, s1
    //prgchk reg s2 == 0xd00ddeaddead00000000000000000000
    li s1, 81
    sll s2, s0, s1
    //prgchk reg s2 == 0xa01bbd5bbd5a00000000000000000000
    li s1, 82
    sll s2, s0, s1
    //prgchk reg s2 == 0x40377ab77ab400000000000000000000
    li s1, 83
    sll s2, s0, s1
    //prgchk reg s2 == 0x806ef56ef56800000000000000000000
    li s1, 84
    sll s2, s0, s1
    //prgchk reg s2 == 0x00ddeaddead000000000000000000000
    li s1, 85
    sll s2, s0, s1
    //prgchk reg s2 == 0x1bbd5bbd5a000000000000000000000
    li s1, 86
    sll s2, s0, s1
    //prgchk reg s2 == 0x377ab77ab4000000000000000000000
    li s1, 87
    sll s2, s0, s1
    //prgchk reg s2 == 0x6ef56ef568000000000000000000000
    li s1, 88
    sll s2, s0, s1
    //prgchk reg s2 == 0xddeaddead0000000000000000000000
    li s1, 89
    sll s2, s0, s1
    //prgchk reg s2 == 0x1bbd5bbd5a0000000000000000000000
    li s1, 90
    sll s2, s0, s1
    //prgchk reg s2 == 0x377ab77ab40000000000000000000000
    li s1, 91
    sll s2, s0, s1
    //prgchk reg s2 == 0x6ef56ef5680000000000000000000000
    li s1, 92
    sll s2, s0, s1
    //prgchk reg s2 == 0xddeaddead00000000000000000000000
    li s1, 93
    sll s2, s0, s1
    //prgchk reg s2 == 0xbbd5bbd5a00000000000000000000000
    li s1, 94
    sll s2, s0, s1
    //prgchk reg s2 == 0x77ab77ab400000000000000000000000
    li s1, 95
    sll s2, s0, s1
    //prgchk reg s2 == 0xef56ef56800000000000000000000000
    li s1, 96
    sll s2, s0, s1
    //prgchk reg s2 == 0xdeaddead000000000000000000000000
    li s1, 97
    sll s2, s0, s1
    //prgchk reg s2 == 0xbd5bbd5a000000000000000000000000
    li s1, 98
    sll s2, s0, s1
    //prgchk reg s2 == 0x7ab77ab4000000000000000000000000
    li s1, 99
    sll s2, s0, s1
    //prgchk reg s2 == 0xf56ef568000000000000000000000000
    li s1, 100
    sll s2, s0, s1
    //prgchk reg s2 == 0xeaddead0000000000000000000000000
    li s1, 101
    sll s2, s0, s1
    //prgchk reg s2 == 0xd5bbd5a0000000000000000000000000
    li s1, 102
    sll s2, s0, s1
    //prgchk reg s2 == 0xab77ab40000000000000000000000000
    li s1, 103
    sll s2, s0, s1
    //prgchk reg s2 == 0x56ef5680000000000000000000000000
    li s1, 104
    sll s2, s0, s1
    //prgchk reg s2 == 0xaddead00000000000000000000000000
    li s1, 105
    sll s2, s0, s1
    //prgchk reg s2 == 0x5bbd5a00000000000000000000000000
    li s1, 106
    sll s2, s0, s1
    //prgchk reg s2 == 0xb77ab400000000000000000000000000
    li s1, 107
    sll s2, s0, s1
    //prgchk reg s2 == 0x6ef56800000000000000000000000000
    li s1, 108
    sll s2, s0, s1
    //prgchk reg s2 == 0xddead000000000000000000000000000
    li s1, 109
    sll s2, s0, s1
    //prgchk reg s2 == 0xbbd5a000000000000000000000000000
    li s1, 110
    sll s2, s0, s1
    //prgchk reg s2 == 0x77ab4000000000000000000000000000
    li s1, 111
    sll s2, s0, s1
    //prgchk reg s2 == 0xef568000000000000000000000000000
    li s1, 112
    sll s2, s0, s1
    //prgchk reg s2 == 0xdead0000000000000000000000000000
    li s1, 113
    sll s2, s0, s1
    //prgchk reg s2 == 0xbd5a0000000000000000000000000000
    li s1, 114
    sll s2, s0, s1
    //prgchk reg s2 == 0x7ab40000000000000000000000000000
    li s1, 115
    sll s2, s0, s1
    //prgchk reg s2 == 0xf5680000000000000000000000000000
    li s1, 116
    sll s2, s0, s1
    //prgchk reg s2 == 0xead00000000000000000000000000000
    li s1, 117
    sll s2, s0, s1
    //prgchk reg s2 == 0xd5a00000000000000000000000000000
    li s1, 118
    sll s2, s0, s1
    //prgchk reg s2 == 0xab400000000000000000000000000000
    li s1, 119
    sll s2, s0, s1
    //prgchk reg s2 == 0x56800000000000000000000000000000
    li s1, 120
    sll s2, s0, s1
    //prgchk reg s2 == 0xad000000000000000000000000000000
    li s1, 121
    sll s2, s0, s1
    //prgchk reg s2 == 0x5a000000000000000000000000000000
    li s1, 122
    sll s2, s0, s1
    //prgchk reg s2 == 0xb4000000000000000000000000000000
    li s1, 123
    sll s2, s0, s1
    //prgchk reg s2 == 0x68000000000000000000000000000000
    li s1, 124
    sll s2, s0, s1
    //prgchk reg s2 == 0xd0000000000000000000000000000000
    li s1, 125
    sll s2, s0, s1
    //prgchk reg s2 == 0xa0000000000000000000000000000000
    li s1, 126
    sll s2, s0, s1
    //prgchk reg s2 == 0x40000000000000000000000000000000
    li s1, 127
    sll s2, s0, s1
    //prgchk reg s2 == 0x80000000000000000000000000000000

    j exit
