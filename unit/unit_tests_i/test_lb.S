#include "exit.S"

.section .data
    tst0: .byte 0x80
    tst1: .byte 0x42
    tst2: .byte 0x00
    tst3: .byte 0xff
    tab_tst: .byte 1, 2, 3, 5, 7, 11, 13, 17, 0xff

.section .text.init,"ax",@progbits
.global _start
_start:
    // Arbitrary value loading (checks sign ext to 128 bits)
    la s0, tst0
    lb s0, 0(s0)
    //prgchk reg s0 == 0xffffffffffffffffffffffffffffff80

    la s0, tst1
    lb s0, 0(s0)
    //prgchk reg s0 == 0x42

    la s0, tst2
    lb s0, 0(s0)
    //prgchk reg s0 == 0

    la s0, tst3
    lb s0, 0(s0)
    //prgchk reg s0 == 0xffffffffffffffffffffffffffffffff

    // Check loads with offsets
    la s0, tab_tst
    lb s1, 0(s0)
    //prgchk reg s1 == 1
    
    lb s1, 1(s0)
    //prgchk reg s1 == 2

    
    lb s1, 2(s0)
    //prgchk reg s1 == 3

    lb s1, 3(s0)
    //prgchk reg s1 == 5

    lb s1, 4(s0)
    //prgchk reg s1 == 7

    lb s1, 5(s0)
    //prgchk reg s1 == 11

    lb s1, 6(s0)
    //prgchk reg s1 == 13

    lb s1, 7(s0)
    //prgchk reg s1 == 17

    lb s1, 8(s0)
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff
    j exit
