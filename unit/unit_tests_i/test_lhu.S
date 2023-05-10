#include "insns.S" 
#include "utils.S"

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
    lhu t0, 0(t0)
    //prgchk reg t0 == 0x00000000000000000000000000008086


    la t0, tst1
    lhu t0, 0(t0)
    //prgchk reg t0 == 0x00000000000000000000000000004243

    la t0, tst2
    lhu t0, 0(t0)
    //prgchk reg t0 == 0

    la t0, tst3
    lhu t0, 0(t0)
    //prgchk reg t0 == 0x0000000000000000000000000000ffff

    // Unaligned loads
    la t1, unaligned_1
    lhu t1, 0(t1)
    //prgchk reg t1 == 0x00000000000000000000000000005341

    // Check loads with offsets.
    la t0, tab_tst
    lhu t1, 0(t0)
    //prgchk reg t1 == 1
    
    lhu t1, 2(t0)
    //prgchk reg t1 == 2
    
    lhu t1, 4(t0)
    //prgchk reg t1 == 3

    lhu t1, 6(t0)
    //prgchk reg t1 == 5

    lhu t1, 8(t0)
    //prgchk reg t1 == 7

    lhu t1, 10(t0)
    //prgchk reg t1 == 11

    lhu t1, 12(t0)
    //prgchk reg t1 == 13

    lhu t1, 14(t0)
    //prgchk reg t1 == 17

    lhu t1, 16(t0)
    //prgchk reg t1 == 0x0000000000000000000000000000ffff
    j exit
