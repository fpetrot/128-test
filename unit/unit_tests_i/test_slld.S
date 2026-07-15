#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check only first 6 bits are used for shift.
    li s0, 0xdeadbeefcafebabe
    //prgchk reg s0 == 0xdeadbeefcafebabe
    li s1, 96 // will correspond to a shift of 32
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffcafebabe00000000

    // Check incremental shifts from 0 to 63.
    li s0, 0xdeadbeefcafebabe
    li s1, 0
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffdeadbeefcafebabe
    li s1, 1
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffbd5b7ddf95fd757c
    li s1, 2
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000007ab6fbbf2bfaeaf8
    li s1, 3
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff56df77e57f5d5f0
    li s1, 4
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffeadbeefcafebabe0
    li s1, 5
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffd5b7ddf95fd757c0
    li s1, 6
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffab6fbbf2bfaeaf80
    li s1, 7
    slld s2, s0, s1
    //prgchk reg s2 == 0x000000000000000056df77e57f5d5f00
    li s1, 8
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffadbeefcafebabe00
    li s1, 9
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000005b7ddf95fd757c00
    li s1, 10
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffb6fbbf2bfaeaf800
    li s1, 11
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000006df77e57f5d5f000
    li s1, 12
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffdbeefcafebabe000
    li s1, 13
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffb7ddf95fd757c000
    li s1, 14
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000006fbbf2bfaeaf8000
    li s1, 15
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffdf77e57f5d5f0000
    li s1, 16
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffbeefcafebabe0000
    li s1, 17
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000007ddf95fd757c0000
    li s1, 18
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffbbf2bfaeaf80000
    li s1, 19
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff77e57f5d5f00000
    li s1, 20
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffeefcafebabe00000
    li s1, 21
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffddf95fd757c00000
    li s1, 22
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffbbf2bfaeaf800000
    li s1, 23
    slld s2, s0, s1
    //prgchk reg s2 == 0x000000000000000077e57f5d5f000000
    li s1, 24
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffefcafebabe000000
    li s1, 25
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffdf95fd757c000000
    li s1, 26
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffbf2bfaeaf8000000
    li s1, 27
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000007e57f5d5f0000000
    li s1, 28
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffcafebabe0000000
    li s1, 29
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff95fd757c0000000
    li s1, 30
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff2bfaeaf80000000
    li s1, 31
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffe57f5d5f00000000
    li s1, 32
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffcafebabe00000000
    li s1, 33
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffff95fd757c00000000
    li s1, 34
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000002bfaeaf800000000
    li s1, 35
    slld s2, s0, s1
    //prgchk reg s2 == 0x000000000000000057f5d5f000000000
    li s1, 36
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffafebabe000000000
    li s1, 37
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000005fd757c000000000
    li s1, 38
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffbfaeaf8000000000
    li s1, 39
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000007f5d5f0000000000
    li s1, 40
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffebabe0000000000
    li s1, 41
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffd757c0000000000
    li s1, 42
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffaeaf80000000000
    li s1, 43
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff5d5f00000000000
    li s1, 44
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffebabe00000000000
    li s1, 45
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffd757c00000000000
    li s1, 46
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffaeaf800000000000
    li s1, 47
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000005d5f000000000000
    li s1, 48
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffbabe000000000000
    li s1, 49
    slld s2, s0, s1
    //prgchk reg s2 == 0x0000000000000000757c000000000000
    li s1, 50
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffeaf8000000000000
    li s1, 51
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffd5f0000000000000
    li s1, 52
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffabe0000000000000
    li s1, 53
    slld s2, s0, s1
    //prgchk reg s2 == 0x000000000000000057c0000000000000
    li s1, 54
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffaf80000000000000
    li s1, 55
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000005f00000000000000
    li s1, 56
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffbe00000000000000
    li s1, 57
    slld s2, s0, s1
    //prgchk reg s2 == 0x00000000000000007c00000000000000
    li s1, 58
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff800000000000000
    li s1, 59
    slld s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffff000000000000000
    li s1, 60
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffe000000000000000
    li s1, 61
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffc000000000000000
    li s1, 62
    slld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffff8000000000000000
    li s1, 63
    slld s2, s0, s1
    //prgchk reg s2 == 0x0
    j exit
