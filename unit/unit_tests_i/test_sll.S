#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    liu(t0, 0xffffffffffffffff)
    //prgchk reg t0 == 0xffffffffffffffff
    liu(t1, 32)
    //prgchk reg t1 == 32

    liu(t2, 0xffffffffffffffff)
    //prgchk reg t2 == 0xffffffffffffffff
    sll t2, t0, t1
    //prgchk reg t2 == 0xffffffff00000000

    srli(t3, t2, 64)
    //prgchk reg t3 == 0x00000000ffffffff

    // Shift by zero
    lui t0, 0
    //progchk reg t0 == 0
    liu(t1, 0xdeadbeefcafebabf)
    //prgchk reg t1 == 0xdeadbeefcafebabf
    sll t2, t1, t0
    //prgchk reg t2 == 0xdeadbeefcafebabf

    // Shift by max shift
    liu(t0, 127)
    //prgchk reg t0 == 127
    sll t2, t1, t0
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x8000000000000000

    // Incremental shifts
    liu(t0, 0xdeadbeefcafebabf)
    slli(t0, t0, 64)
    liu(t1, 0xcafed00ddeaddead)
    or t0, t0, t1
    liu(t1, 0)
    sll t2, t0, t1
    //prgchk reg t2 == 0xcafed00ddeaddead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeadbeefcafebabf
    liu(t1, 1)
    sll t2, t0, t1
    //prgchk reg t2 == 0x95fda01bbd5bbd5a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbd5b7ddf95fd757f
    liu(t1, 2)
    sll t2, t0, t1
    //prgchk reg t2 == 0x2bfb40377ab77ab4
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7ab6fbbf2bfaeaff
    li t1, 3
    sll t2, t0, t1
    //prgchk reg t2 == 0x57f6806ef56ef568
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf56df77e57f5d5fe
    li t1, 4
    sll t2, t0, t1
    //prgchk reg t2 == 0xafed00ddeaddead0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xeadbeefcafebabfc
    li t1, 5
    sll t2, t0, t1
    //prgchk reg t2 == 0x5fda01bbd5bbd5a0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xd5b7ddf95fd757f9
    li t1, 6
    sll t2, t0, t1
    //prgchk reg t2 == 0xbfb40377ab77ab40
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xab6fbbf2bfaeaff2
    li t1, 7
    sll t2, t0, t1
    //prgchk reg t2 == 0x7f6806ef56ef5680
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x56df77e57f5d5fe5
    li t1, 8
    sll t2, t0, t1
    //prgchk reg t2 == 0xfed00ddeaddead00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xadbeefcafebabfca
    li t1, 9
    sll t2, t0, t1
    //prgchk reg t2 == 0xfda01bbd5bbd5a00
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x5b7ddf95fd757f95
    li t1, 10
    sll t2, t0, t1
    //prgchk reg t2 == 0xfb40377ab77ab400
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xb6fbbf2bfaeaff2b
    li t1, 11
    sll t2, t0, t1
    //prgchk reg t2 == 0xf6806ef56ef56800
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6df77e57f5d5fe57
    li t1, 12
    sll t2, t0, t1
    //prgchk reg t2 == 0xed00ddeaddead000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdbeefcafebabfcaf
    li t1, 13
    sll t2, t0, t1
    //prgchk reg t2 == 0xda01bbd5bbd5a000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xb7ddf95fd757f95f
    li t1, 14
    sll t2, t0, t1
    //prgchk reg t2 == 0xb40377ab77ab4000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6fbbf2bfaeaff2bf
    li t1, 15
    sll t2, t0, t1
    //prgchk reg t2 == 0x6806ef56ef568000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdf77e57f5d5fe57f
    li t1, 16
    sll t2, t0, t1
    //prgchk reg t2 == 0xd00ddeaddead0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbeefcafebabfcafe
    li t1, 17
    sll t2, t0, t1
    //prgchk reg t2 == 0xa01bbd5bbd5a0000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7ddf95fd757f95fd
    li t1, 18
    sll t2, t0, t1
    //prgchk reg t2 == 0x40377ab77ab40000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfbbf2bfaeaff2bfb
    li t1, 19
    sll t2, t0, t1
    //prgchk reg t2 == 0x806ef56ef5680000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf77e57f5d5fe57f6
    li t1, 20
    sll t2, t0, t1
    //prgchk reg t2 == 0xddeaddead00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xeefcafebabfcafed
    li t1, 21
    sll t2, t0, t1
    //prgchk reg t2 == 0x1bbd5bbd5a00000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xddf95fd757f95fda
    li t1, 22
    sll t2, t0, t1
    //prgchk reg t2 == 0x377ab77ab400000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbbf2bfaeaff2bfb4
    li t1, 23
    sll t2, t0, t1
    //prgchk reg t2 == 0x6ef56ef56800000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x77e57f5d5fe57f68
    li t1, 24
    sll t2, t0, t1
    //prgchk reg t2 == 0xddeaddead000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xefcafebabfcafed0
    li t1, 25
    sll t2, t0, t1
    //prgchk reg t2 == 0x1bbd5bbd5a000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdf95fd757f95fda0
    li t1, 26
    sll t2, t0, t1
    //prgchk reg t2 == 0x377ab77ab4000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbf2bfaeaff2bfb40
    li t1, 27
    sll t2, t0, t1
    //prgchk reg t2 == 0x6ef56ef568000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7e57f5d5fe57f680
    li t1, 28
    sll t2, t0, t1
    //prgchk reg t2 == 0xddeaddead0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfcafebabfcafed00
    li t1, 29
    sll t2, t0, t1
    //prgchk reg t2 == 0xbbd5bbd5a0000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf95fd757f95fda01
    li t1, 30
    sll t2, t0, t1
    //prgchk reg t2 == 0x77ab77ab40000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf2bfaeaff2bfb403
    li t1, 31
    sll t2, t0, t1
    //prgchk reg t2 == 0xef56ef5680000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xe57f5d5fe57f6806
    li t1, 32
    sll t2, t0, t1
    //prgchk reg t2 == 0xdeaddead00000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xcafebabfcafed00d
    li t1, 33
    sll t2, t0, t1
    //prgchk reg t2 == 0xbd5bbd5a00000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x95fd757f95fda01b
    li t1, 34
    sll t2, t0, t1
    //prgchk reg t2 == 0x7ab77ab400000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x2bfaeaff2bfb4037
    li t1, 35
    sll t2, t0, t1
    //prgchk reg t2 == 0xf56ef56800000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x57f5d5fe57f6806e
    li t1, 36
    sll t2, t0, t1
    //prgchk reg t2 == 0xeaddead000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xafebabfcafed00dd
    li t1, 37
    sll t2, t0, t1
    //prgchk reg t2 == 0xd5bbd5a000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x5fd757f95fda01bb
    li t1, 38
    sll t2, t0, t1
    //prgchk reg t2 == 0xab77ab4000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbfaeaff2bfb40377
    li t1, 39
    sll t2, t0, t1
    //prgchk reg t2 == 0x56ef568000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7f5d5fe57f6806ef
    li t1, 40
    sll t2, t0, t1
    //prgchk reg t2 == 0xaddead0000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfebabfcafed00dde
    li t1, 41
    sll t2, t0, t1
    //prgchk reg t2 == 0x5bbd5a0000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfd757f95fda01bbd
    li t1, 42
    sll t2, t0, t1
    //prgchk reg t2 == 0xb77ab40000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfaeaff2bfb40377a
    li t1, 43
    sll t2, t0, t1
    //prgchk reg t2 == 0x6ef5680000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf5d5fe57f6806ef5
    li t1, 44
    sll t2, t0, t1
    //prgchk reg t2 == 0xddead00000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xebabfcafed00ddea
    li t1, 45
    sll t2, t0, t1
    //prgchk reg t2 == 0xbbd5a00000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xd757f95fda01bbd5
    li t1, 46
    sll t2, t0, t1
    //prgchk reg t2 == 0x77ab400000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xaeaff2bfb40377ab
    li t1, 47
    sll t2, t0, t1
    //prgchk reg t2 == 0xef56800000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x5d5fe57f6806ef56
    li t1, 48
    sll t2, t0, t1
    //prgchk reg t2 == 0xdead000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbabfcafed00ddead
    li t1, 49
    sll t2, t0, t1
    //prgchk reg t2 == 0xbd5a000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x757f95fda01bbd5b
    li t1, 50
    sll t2, t0, t1
    //prgchk reg t2 == 0x7ab4000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xeaff2bfb40377ab7
    li t1, 51
    sll t2, t0, t1
    //prgchk reg t2 == 0xf568000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xd5fe57f6806ef56e
    li t1, 52
    sll t2, t0, t1
    //prgchk reg t2 == 0xead0000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xabfcafed00ddeadd
    li t1, 53
    sll t2, t0, t1
    //prgchk reg t2 == 0xd5a0000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x57f95fda01bbd5bb
    li t1, 54
    sll t2, t0, t1
    //prgchk reg t2 == 0xab40000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xaff2bfb40377ab77
    li t1, 55
    sll t2, t0, t1
    //prgchk reg t2 == 0x5680000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x5fe57f6806ef56ef
    li t1, 56
    sll t2, t0, t1
    //prgchk reg t2 == 0xad00000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbfcafed00ddeadde
    li t1, 57
    sll t2, t0, t1
    //prgchk reg t2 == 0x5a00000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7f95fda01bbd5bbd
    li t1, 58
    sll t2, t0, t1
    //prgchk reg t2 == 0xb400000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xff2bfb40377ab77a
    li t1, 59
    sll t2, t0, t1
    //prgchk reg t2 == 0x6800000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfe57f6806ef56ef5
    li t1, 60
    sll t2, t0, t1
    //prgchk reg t2 == 0xd000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfcafed00ddeaddea
    li t1, 61
    sll t2, t0, t1
    //prgchk reg t2 == 0xa000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf95fda01bbd5bbd5
    li t1, 62
    sll t2, t0, t1
    //prgchk reg t2 == 0x4000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf2bfb40377ab77ab
    li t1, 63
    sll t2, t0, t1
    //prgchk reg t2 == 0x8000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xe57f6806ef56ef56
    li t1, 64
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xcafed00ddeaddead
    li t1, 65
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x95fda01bbd5bbd5a
    li t1, 66
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x2bfb40377ab77ab4
    li t1, 67
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x57f6806ef56ef568
    li t1, 68
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xafed00ddeaddead0
    li t1, 69
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x5fda01bbd5bbd5a0
    li t1, 70
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbfb40377ab77ab40
    li t1, 71
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7f6806ef56ef5680
    li t1, 72
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfed00ddeaddead00
    li t1, 73
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfda01bbd5bbd5a00
    li t1, 74
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfb40377ab77ab400
    li t1, 75
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf6806ef56ef56800
    li t1, 76
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xed00ddeaddead000
    li t1, 77
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xda01bbd5bbd5a000
    li t1, 78
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xb40377ab77ab4000
    li t1, 79
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6806ef56ef568000
    li t1, 80
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xd00ddeaddead0000
    li t1, 81
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xa01bbd5bbd5a0000
    li t1, 82
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x40377ab77ab40000
    li t1, 83
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x806ef56ef5680000
    li t1, 84
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xddeaddead00000
    li t1, 85
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bbd5bbd5a00000
    li t1, 86
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x377ab77ab400000
    li t1, 87
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6ef56ef56800000
    li t1, 88
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xddeaddead000000
    li t1, 89
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x1bbd5bbd5a000000
    li t1, 90
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x377ab77ab4000000
    li t1, 91
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6ef56ef568000000
    li t1, 92
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xddeaddead0000000
    li t1, 93
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbbd5bbd5a0000000
    li t1, 94
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x77ab77ab40000000
    li t1, 95
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xef56ef5680000000
    li t1, 96
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdeaddead00000000
    li t1, 97
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbd5bbd5a00000000
    li t1, 98
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7ab77ab400000000
    li t1, 99
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf56ef56800000000
    li t1, 100
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xeaddead000000000
    li t1, 101
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xd5bbd5a000000000
    li t1, 102
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xab77ab4000000000
    li t1, 103
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x56ef568000000000
    li t1, 104
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xaddead0000000000
    li t1, 105
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x5bbd5a0000000000
    li t1, 106
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xb77ab40000000000
    li t1, 107
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6ef5680000000000
    li t1, 108
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xddead00000000000
    li t1, 109
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbbd5a00000000000
    li t1, 110
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x77ab400000000000
    li t1, 111
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xef56800000000000
    li t1, 112
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xdead000000000000
    li t1, 113
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xbd5a000000000000
    li t1, 114
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7ab4000000000000
    li t1, 115
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xf568000000000000
    li t1, 116
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xead0000000000000
    li t1, 117
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xd5a0000000000000
    li t1, 118
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xab40000000000000
    li t1, 119
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x5680000000000000
    li t1, 120
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xad00000000000000
    li t1, 121
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x5a00000000000000
    li t1, 122
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xb400000000000000
    li t1, 123
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x6800000000000000
    li t1, 124
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xd000000000000000
    li t1, 125
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xa000000000000000
    li t1, 126
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x4000000000000000
    li t1, 127
    sll t2, t0, t1
    //prgchk reg t2 == 0x0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x8000000000000000

j exit