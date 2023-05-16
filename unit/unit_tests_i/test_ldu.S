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
    la t0, tst1
    ldu t0, 0(t0)
    //prgchk reg t0 == 0xffffffffffffffff

    la t1, tst2
    ldu t1, 0(t1)
    //prgchk reg t1 == 0xfedcba9876543210

    la t1, tst3
    ldu t1, 0(t1)
    //prgchk reg t1 == 0x1234567890abcdef

    // Loading with different offsets.
    la t0, tab_tst
    ldu t1, 0(t0)
    //prgchk reg t1 == 1

    ldu t1, 8(t0)
    //prgchk reg t1 == 2

    ldu t1, 16(t0)
    //prgchk reg t1 == 3
    
    ldu t1, 24(t0)
    //prgchk reg t1 == 5

    ldu t1, 32(t0)
    //prgchk reg t1 == 7

    ldu t1, 40(t0)
    //prgchk reg t1 == 11

    ldu t1, 48(t0) 
    //prgchk reg t1 == 13

    ldu t1, 56(t0) 
    //prgchk reg t1 == 17

    ldu t1, 64(t0) 
    //prgchk reg t1 == 0xffffffffffffffff

    // Testing unaligned reads.
    la t0, unaligned1
    ldu t1, 0(t0) 
    //prgchk reg t1 == 0xabcdef0123456789

    la t0, unaligned2
    ldu t1, 0(t0)
    //prgchk reg t1 == 0xfedcba9876543210

    la t0, unaligned3
    ldu t1, 0(t0)
    //prgchk reg t1 == 0xdeadbeefbeefdead

    la t0, unaligned4
    ldu t1, 0(t0)
    //prgchk reg t1 == 0xcafebabebabecafe

    la t0, unaligned5
    ldu t1, 0(t0)
    //prgchk reg t1 == 0xabcdabcdabcdabcd

    la t0, unaligned6
    ldu t1, 0(t0)
    //prgchk reg t1 == 0xeeffeeffeeffeeff

    la t0, unaligned7
    ldu t1, 0(t0)
    //prgchk reg t1 == 0x4242424242424242
    j exit
