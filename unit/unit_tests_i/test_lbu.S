#include "insns.S" 
#include "utils.S"

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
    lbu t0, 0(t0)
    //prgchk reg t0 == 0x000000000000000080

    la t0, tst1
    lbu t0, 0(t0)
    //prgchk reg t0 == 0x000000000000000042

    la t0, tst2
    lbu t0, 0(t0)
    //prgchk reg t0 == 0


    la t0, tst3
    lbu t0, 0(t0)
    //prgchk reg t0 == 0x0000000000000000ff


    // Check loads with offsets
    la t0, tab_tst
    lbu t1, 0(t0)
    //prgchk reg t1 == 0X00000000000000000000000000000001

    
    lbu t1, 1(t0)
    //prgchk reg t1 == 0X00000000000000000000000000000002

    
    lbu t1, 2(t0)
    //prgchk reg t1 == 0X00000000000000000000000000000003


    lbu t1, 3(t0)
    //prgchk reg t1 == 0X00000000000000000000000000000005


    lbu t1, 4(t0)
    //prgchk reg t1 == 0X00000000000000000000000000000007


    lbu t1, 5(t0)
    //prgchk reg t1 == 0X0000000000000000000000000000000b


    lbu t1, 6(t0)
    //prgchk reg t1 == 0x0000000000000000000000000000000d


    lbu t1, 7(t0)
    //prgchk reg t1 == 0x00000000000000000000000000000011


    lbu t1, 8(t0)
    //prgchk reg t1 == 0x000000000000000000000000000000ff

    j exit
