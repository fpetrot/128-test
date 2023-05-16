#include "exit.S"

.section .data
    tst0: .half 0x8086
    tst1: .half 0x4243
    tst2: .half 0x0000
    tst3: .half 0xffff
    tab_tst: .half 1, 2, 3, 5, 7, 11, 13, 17, 0xffff
    .align 2
    .byte 0xde
    unaligned_1: .half 0x5341

.section .text.init,"ax",@progbits
.global _start
_start:
    // Arbitrary value loading (checks sign ext to 128 bits)
    la t0, tst0
    lh t0, 0(t0)
    //prgchk reg t0 == 0xffffffffffffffffffffffffffff8086

    la t0, tst1
    lh t0, 0(t0)
    //prgchk reg t0 == 0x4243

    la t0, tst2
    lh t0, 0(t0)
    //prgchk reg t0 == 0

    la t0, tst3
    lh t0, 0(t0)
    //prgchk reg t0 == 0xffffffffffffffffffffffffffffffff

    // Unaligned loads
    la t1, unaligned_1
    lh t1, 0(t1)
    //prgchk reg t1 == 0x00000000000000000000000000005341

    // Check loads with offsets.
    la t0, tab_tst
    lh t1, 0(t0)
    //prgchk reg t1 == 0x000000000000000000000000000001
    
    lh t1, 2(t0)
    //prgchk reg t1 == 0x000000000000000000000000000002
    
    lh t1, 4(t0)
    //prgchk reg t1 == 0x000000000000000000000000000003

    lh t1, 6(t0)
    //prgchk reg t1 == 0x000000000000000000000000000005

    lh t1, 8(t0)
    //prgchk reg t1 == 0x000000000000000000000000000007

    lh t1, 10(t0)
    //prgchk reg t1 == 0x00000000000000000000000000000b

    lh t1, 12(t0)
    //prgchk reg t1 == 0x00000000000000000000000000000d

    lh t1, 14(t0)
    //prgchk reg t1 == 0x000000000000000000000000000011

    lh t1, 16(t0)
    //prgchk reg t1 == 0xffffffffffffffffffffffffffffffff

    j exit
