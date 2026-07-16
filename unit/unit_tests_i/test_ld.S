#include "exit.S"

.section .data
    tst1:          .dword 0xffffffffffffffff
    tst2:          .dword 0xfedcba9876543210
    tst3:          .dword 0x1234567890abcdef
    tab_tst:       .dword 1, 2, 3, 5, 7, 11, 13, 17, 19

.section .text.init,"ax",@progbits
.global _start
_start:
    // Test sign extension to 128 bits.
    la s0, tst1
    ld s0, 0(s0)
    //prgchk reg s0 == 0xffffffffffffffffffffffffffffffff

    la s1, tst2
    ld s1, 0(s1)
    //prgchk reg s1 == 0xfffffffffffffffffedcba9876543210

    la s1, tst3
    ld s1, 0(s1)
    //prgchk reg s1 == 0x00000000000000001234567890abcdef

    // Loading with different offsets.
    la s0, tab_tst
    ld s1, 0(s0)
    //prgchk reg s1 == 1

    ld s1, 8(s0)
    //prgchk reg s1 == 2

    ld s1, 16(s0)
    //prgchk reg s1 == 3
    
    ld s1, 24(s0)
    //prgchk reg s1 == 5

    ld s1, 32(s0)
    //prgchk reg s1 == 7

    ld s1, 40(s0)
    //prgchk reg s1 == 11

    ld s1, 48(s0)
    //prgchk reg s1 == 13

    ld s1, 56(s0)
    //prgchk reg s1 == 17

    ld s1, 64(s0)
    //prgchk reg s1 == 19

    j exit
