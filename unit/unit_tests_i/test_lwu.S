#include "insns.S" 
#include "utils.S"

.section .data
    tst0: .word 0x80386387
    tst1: .word 0x42434445
    tst2: .word 0x00000000
    tst3: .word 0xffffffff
    tab_tst: .word 1, 2, 3, 5, 7, 11, 13, 17, 0xffffffff
    .align 4
    .byte 0xde
    unaligned_1: .word 0xcafebabe
    .byte 0xad
    unaligned_2: .word 0x12345678
    .byte 0xbe
    unaligned_3: .word 0x87654321

.section .text.init,"ax",@progbits
.global _start
_start:
    // Arbitrary value loading (checks sign ext to 128 bits)
    la t0, tst0
    lwu t0, 0(t0)
    //prgchk reg t0 == 0x00000000000000000000000080386387

    la t0, tst1
    lwu t0, 0(t0)
    //prgchk reg t0 == 0x00000000000000000000000042434445

    la t0, tst2
    lwu t0, 0(t0)
    //prgchk reg t0 == 0

    la t0, tst3
    lwu t0, 0(t0)
    //prgchk reg t0 == 0x000000000000000000000000ffffffff

    // Unaligned reads.
    la t1, unaligned_1
    lwu t1, 0(t1)
    //prgchk reg t1 == 0x000000000000000000000000cafebabe

    la t1, unaligned_2
    lwu t1, 0(t1)
    //prgchk reg t1 == 0x00000000000000000000000012345678

    la t1, unaligned_3
    lwu t1, 0(t1)
    //prgchk reg t1 == 0x00000000000000000000000087654321

    // Check loads with offsets.
    la t0, tab_tst
    lwu t1, 0(t0)
    //prgchk reg t1 == 1
    
    lwu t1, 4(t0)
    //prgchk reg t1 == 2
    
    lwu t1, 8(t0)
    //prgchk reg t1 == 3

    lwu t1, 12(t0)
    //prgchk reg t1 == 5

    lwu t1, 16(t0)
    //prgchk reg t1 == 7

    lwu t1, 20(t0)
    //prgchk reg t1 == 11

    lwu t1, 24(t0)
    //prgchk reg t1 == 13

    lwu t1, 28(t0)
    //prgchk reg t1 == 17

    lwu t1, 32(t0)
    //prgchk reg t1 == 0x000000000000000000000000ffffffff
    j exit
