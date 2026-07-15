#include "exit.S"

.section .data
    tst1:          .dword 0xffffffffffffffff
    tst2:          .dword 0xfedcba9876543210
    tst3:          .dword 0x1234567890abcdef
    tab_tst:       .dword 1, 2, 3, 5, 7, 11, 13, 17, 0xffffffffffffffff
    .align 8
    .byte 0xff
    unaligned1: .dword 0xabcdef0123456789
    .byte 0xff
    unaligned2: .dword 0xfedcba9876543210
    .byte 0xff
    unaligned3: .dword 0xdeadbeefbeefdead
    .byte 0xff
    unaligned4: .dword 0xcafebabebabecafe
    .byte 0xff
    unaligned5: .dword 0xabcdabcdabcdabcd
    .byte 0xff
    unaligned6: .dword 0xeeffeeffeeffeeff
    .byte 0xff
    unaligned7: .dword 0x4242424242424242

.section .text.init,"ax",@progbits
.global _start
_start:
    // Test (non) sign extension to 128 bits.
    la s0, tst1
    ldu s0, 0(s0)
    //prgchk reg s0 == 0xffffffffffffffff

    la s1, tst2
    ldu s1, 0(s1)
    //prgchk reg s1 == 0xfedcba9876543210

    la s1, tst3
    ldu s1, 0(s1)
    //prgchk reg s1 == 0x1234567890abcdef

    // Loading with different offsets.
    la s0, tab_tst
    ldu s1, 0(s0)
    //prgchk reg s1 == 1

    ldu s1, 8(s0)
    //prgchk reg s1 == 2

    ldu s1, 16(s0)
    //prgchk reg s1 == 3
    
    ldu s1, 24(s0)
    //prgchk reg s1 == 5

    ldu s1, 32(s0)
    //prgchk reg s1 == 7

    ldu s1, 40(s0)
    //prgchk reg s1 == 11

    ldu s1, 48(s0) 
    //prgchk reg s1 == 13

    ldu s1, 56(s0) 
    //prgchk reg s1 == 17

    ldu s1, 64(s0) 
    //prgchk reg s1 == 0xffffffffffffffff

    // Testing unaligned reads.
    la s0, unaligned1
    ldu s1, 0(s0) 
    //prgchk reg s1 == 0xabcdef0123456789

    la s0, unaligned2
    ldu s1, 0(s0)
    //prgchk reg s1 == 0xfedcba9876543210

    la s0, unaligned3
    ldu s1, 0(s0)
    //prgchk reg s1 == 0xdeadbeefbeefdead

    la s0, unaligned4
    ldu s1, 0(s0)
    //prgchk reg s1 == 0xcafebabebabecafe

    la s0, unaligned5
    ldu s1, 0(s0)
    //prgchk reg s1 == 0xabcdabcdabcdabcd

    la s0, unaligned6
    ldu s1, 0(s0)
    //prgchk reg s1 == 0xeeffeeffeeffeeff

    la s0, unaligned7
    ldu s1, 0(s0)
    //prgchk reg s1 == 0x4242424242424242
    j exit
