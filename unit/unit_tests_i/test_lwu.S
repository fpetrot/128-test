#include "exit.S"

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
    la s0, tst0
    lwu s0, 0(s0)
    //prgchk reg s0 == 0x80386387

    la s0, tst1
    lwu s0, 0(s0)
    //prgchk reg s0 == 0x42434445

    la s0, tst2
    lwu s0, 0(s0)
    //prgchk reg s0 == 0

    la s0, tst3
    lwu s0, 0(s0)
    //prgchk reg s0 == 0xffffffff

    // Unaligned reads.
    la s1, unaligned_1
    lwu s1, 0(s1)
    //prgchk reg s1 == 0xcafebabe

    la s1, unaligned_2
    lwu s1, 0(s1)
    //prgchk reg s1 == 0x12345678

    la s1, unaligned_3
    lwu s1, 0(s1)
    //prgchk reg s1 == 0x87654321

    // Check loads with offsets.
    la s0, tab_tst
    lwu s1, 0(s0)
    //prgchk reg s1 == 1
    
    lwu s1, 4(s0)
    //prgchk reg s1 == 2
    
    lwu s1, 8(s0)
    //prgchk reg s1 == 3

    lwu s1, 12(s0)
    //prgchk reg s1 == 5

    lwu s1, 16(s0)
    //prgchk reg s1 == 7

    lwu s1, 20(s0)
    //prgchk reg s1 == 11

    lwu s1, 24(s0)
    //prgchk reg s1 == 13

    lwu s1, 28(s0)
    //prgchk reg s1 == 17

    lwu s1, 32(s0)
    //prgchk reg s1 == 0xffffffff
    j exit
