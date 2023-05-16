#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check only first 6 bits are used for shift.
    li t0, 0xdeadbeefcafebabe
    li t1, 96 // will correspond to a shift of 32
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffcafebabe00000000

    // Check incremental shifts from 0 to 63.
    li t0, 0xdeadbeefcafebabe
    li t1, 0
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffdeadbeefcafebabe
    li t1, 1
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffbd5b7ddf95fd757c
    li t1, 2
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000007ab6fbbf2bfaeaf8
    li t1, 3
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff56df77e57f5d5f0
    li t1, 4
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffeadbeefcafebabe0
    li t1, 5
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffd5b7ddf95fd757c0
    li t1, 6
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffab6fbbf2bfaeaf80
    li t1, 7
    slld t2, t0, t1
    //prgchk reg t2 == 0x000000000000000056df77e57f5d5f00
    li t1, 8
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffadbeefcafebabe00
    li t1, 9
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000005b7ddf95fd757c00
    li t1, 10
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffb6fbbf2bfaeaf800
    li t1, 11
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000006df77e57f5d5f000
    li t1, 12
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffdbeefcafebabe000
    li t1, 13
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffb7ddf95fd757c000
    li t1, 14
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000006fbbf2bfaeaf8000
    li t1, 15
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffdf77e57f5d5f0000
    li t1, 16
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffbeefcafebabe0000
    li t1, 17
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000007ddf95fd757c0000
    li t1, 18
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffbbf2bfaeaf80000
    li t1, 19
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff77e57f5d5f00000
    li t1, 20
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffeefcafebabe00000
    li t1, 21
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffddf95fd757c00000
    li t1, 22
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffbbf2bfaeaf800000
    li t1, 23
    slld t2, t0, t1
    //prgchk reg t2 == 0x000000000000000077e57f5d5f000000
    li t1, 24
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffefcafebabe000000
    li t1, 25
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffdf95fd757c000000
    li t1, 26
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffbf2bfaeaf8000000
    li t1, 27
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000007e57f5d5f0000000
    li t1, 28
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffcafebabe0000000
    li t1, 29
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff95fd757c0000000
    li t1, 30
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff2bfaeaf80000000
    li t1, 31
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffe57f5d5f00000000
    li t1, 32
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffcafebabe00000000
    li t1, 33
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff95fd757c00000000
    li t1, 34
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000002bfaeaf800000000
    li t1, 35
    slld t2, t0, t1
    //prgchk reg t2 == 0x000000000000000057f5d5f000000000
    li t1, 36
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffafebabe000000000
    li t1, 37
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000005fd757c000000000
    li t1, 38
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffbfaeaf8000000000
    li t1, 39
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000007f5d5f0000000000
    li t1, 40
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffebabe0000000000
    li t1, 41
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffd757c0000000000
    li t1, 42
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffffaeaf80000000000
    li t1, 43
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff5d5f00000000000
    li t1, 44
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffebabe00000000000
    li t1, 45
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffd757c00000000000
    li t1, 46
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffaeaf800000000000
    li t1, 47
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000005d5f000000000000
    li t1, 48
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffbabe000000000000
    li t1, 49
    slld t2, t0, t1
    //prgchk reg t2 == 0x0000000000000000757c000000000000
    li t1, 50
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffeaf8000000000000
    li t1, 51
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffd5f0000000000000
    li t1, 52
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffabe0000000000000
    li t1, 53
    slld t2, t0, t1
    //prgchk reg t2 == 0x000000000000000057c0000000000000
    li t1, 54
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffaf80000000000000
    li t1, 55
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000005f00000000000000
    li t1, 56
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffbe00000000000000
    li t1, 57
    slld t2, t0, t1
    //prgchk reg t2 == 0x00000000000000007c00000000000000
    li t1, 58
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff800000000000000
    li t1, 59
    slld t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffff000000000000000
    li t1, 60
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffe000000000000000
    li t1, 61
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffc000000000000000
    li t1, 62
    slld t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff8000000000000000
    li t1, 63
    slld t2, t0, t1
    //prgchk reg t2 == 0x0
    j exit
