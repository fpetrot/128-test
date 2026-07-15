#include "exit.S"

.section .data
    tst0: .byte 0x80
    tst1: .byte 0x42
    tst2: .byte 0x00
    tst3: .byte 0xff
    tab_tst: .byte 1, 2, 3, 5, 7, 11, 13, 17, 255

.section .text.init,"ax",@progbits
.global _start
_start:
    // Arbitrary value loading (checks sign ext to 128 bits)
    la s0, tst0
    lbu s0, 0(s0)
    //prgchk reg s0 == 0x80

    la s0, tst1
    lbu s0, 0(s0)
    //prgchk reg s0 == 0x42

    la s0, tst2
    lbu s0, 0(s0)
    //prgchk reg s0 == 0


    la s0, tst3
    lbu s0, 0(s0)
    //prgchk reg s0 == 0xff


    // Check loads with offsets
    la s0, tab_tst
    lbu s1, 0(s0)
    //prgchk reg s1 == 1

    
    lbu s1, 1(s0)
    //prgchk reg s1 == 2

    
    lbu s1, 2(s0)
    //prgchk reg s1 == 3


    lbu s1, 3(s0)
    //prgchk reg s1 == 5


    lbu s1, 4(s0)
    //prgchk reg s1 == 7


    lbu s1, 5(s0)
    //prgchk reg s1 == 11


    lbu s1, 6(s0)
    //prgchk reg s1 == 13


    lbu s1, 7(s0)
    //prgchk reg s1 == 17


    lbu s1, 8(s0)
    //prgchk reg s1 == 255

    j exit
