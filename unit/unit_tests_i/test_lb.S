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
    la t0, tst0
    lb t0, 0(t0)
    //prgchk reg t0 == 0xffffffffffffffffffffffffffffff80

    la t0, tst1
    lb t0, 0(t0)
    //prgchk reg t0 == 0x42

    la t0, tst2
    lb t0, 0(t0)
    //prgchk reg t0 == 0

    la t0, tst3
    lb t0, 0(t0)
    //prgchk reg t0 == 0xffffffffffffffffffffffffffffffff

    // Check loads with offsets
    la t0, tab_tst
    lb t1, 0(t0)
    //prgchk reg t1 == 1
    
    lb t1, 1(t0)
    //prgchk reg t1 == 2

    
    lb t1, 2(t0)
    //prgchk reg t1 == 3

    lb t1, 3(t0)
    //prgchk reg t1 == 5

    lb t1, 4(t0)
    //prgchk reg t1 == 7

    lb t1, 5(t0)
    //prgchk reg t1 == 11

    lb t1, 6(t0)
    //prgchk reg t1 == 13

    lb t1, 7(t0)
    //prgchk reg t1 == 17

    lb t1, 8(t0)
    //prgchk reg t1 == 0xffffffffffffffffffffffffffffffff
    j exit
