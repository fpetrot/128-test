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
    lh s0, 0(s0)
    //prgchk reg s0 == 0xffffffffffffffffffffffffffff8086

    la s0, tst1
    lh s0, 0(s0)
    //prgchk reg s0 == 0x4243

    la s0, tst2
    lh s0, 0(s0)
    //prgchk reg s0 == 0

    la s0, tst3
    lh s0, 0(s0)
    //prgchk reg s0 == 0xffffffffffffffffffffffffffffffff

    // Check loads with offsets.
    la s0, tab_tst
    lh s1, 0(s0)
    //prgchk reg s1 == 0x000000000000000000000000000001
    
    lh s1, 2(s0)
    //prgchk reg s1 == 0x000000000000000000000000000002
    
    lh s1, 4(s0)
    //prgchk reg s1 == 0x000000000000000000000000000003

    lh s1, 6(s0)
    //prgchk reg s1 == 0x000000000000000000000000000005

    lh s1, 8(s0)
    //prgchk reg s1 == 0x000000000000000000000000000007

    lh s1, 10(s0)
    //prgchk reg s1 == 0x00000000000000000000000000000b

    lh s1, 12(s0)
    //prgchk reg s1 == 0x00000000000000000000000000000d

    lh s1, 14(s0)
    //prgchk reg s1 == 0x000000000000000000000000000011

    lh s1, 16(s0)
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    j exit
