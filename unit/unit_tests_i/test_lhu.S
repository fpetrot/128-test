#include "exit.S"

.section .data
    tst0: .half 0x8086
    tst1: .half 0x4243
    tst2: .half 0x0000
    tst3: .half 0xffff
    tab_tst: .half 1, 2, 3, 5, 7, 11, 13, 17, 0xffff

.section .text.init,"ax",@progbits
.global _start
_start:
    // Arbitrary value loading (checks sign ext to 128 bits)
    la s0, tst0
    lhu s0, 0(s0)
    //prgchk reg s0 == 0x00000000000000000000000000008086


    la s0, tst1
    lhu s0, 0(s0)
    //prgchk reg s0 == 0x00000000000000000000000000004243

    la s0, tst2
    lhu s0, 0(s0)
    //prgchk reg s0 == 0

    la s0, tst3
    lhu s0, 0(s0)
    //prgchk reg s0 == 0x0000000000000000000000000000ffff

    // Check loads with offsets.
    la s0, tab_tst
    lhu s1, 0(s0)
    //prgchk reg s1 == 1
    
    lhu s1, 2(s0)
    //prgchk reg s1 == 2
    
    lhu s1, 4(s0)
    //prgchk reg s1 == 3

    lhu s1, 6(s0)
    //prgchk reg s1 == 5

    lhu s1, 8(s0)
    //prgchk reg s1 == 7

    lhu s1, 10(s0)
    //prgchk reg s1 == 11

    lhu s1, 12(s0)
    //prgchk reg s1 == 13

    lhu s1, 14(s0)
    //prgchk reg s1 == 17

    lhu s1, 16(s0)
    //prgchk reg s1 == 0x0000000000000000000000000000ffff
    j exit
