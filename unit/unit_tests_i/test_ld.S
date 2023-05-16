#include "exit.S"

.section .data
    tst1:          .dword 0xffffffffffffffff
    tst2:          .dword 0xfedcba9876543210
    tst3:          .dword 0x1234567890abcdef
    tab_tst:       .dword 1, 2, 3, 5, 7, 11, 13, 17, 19
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
    unaligned5: .dword 0xabadadddabcdabed
    .byte 0xff
    unaligned6: .dword 0xeeffeeffeeffeeff
    .byte 0xff
    unaligned7: .dword 0x5879545963448eee

.section .text.init,"ax",@progbits
.global _start
_start:
    // Test sign extension to 128 bits.
    la t0, tst1
    ld t0, 0(t0)
    //prgchk reg t0 == 0xffffffffffffffffffffffffffffffff

    la t1, tst2
    ld t1, 0(t1)
    //prgchk reg t1 == 0xfffffffffffffffffedcba9876543210

    la t1, tst3
    ld t1, 0(t1)
    //prgchk reg t1 == 0x00000000000000001234567890abcdef

    // Loading with different offsets.
    la t0, tab_tst
    ld t1, 0(t0)
    //prgchk reg t1 == 1

    ld t1, 8(t0)
    //prgchk reg t1 == 2

    ld t1, 16(t0)
    //prgchk reg t1 == 3
    
    ld t1, 24(t0)
    //prgchk reg t1 == 5

    ld t1, 32(t0)
    //prgchk reg t1 == 7

    ld t1, 40(t0)
    //prgchk reg t1 == 11

    ld t1, 48(t0)
    //prgchk reg t1 == 13

    ld t1, 56(t0)
    //prgchk reg t1 == 17

    ld t1, 64(t0)
    //prgchk reg t1 == 19

    // Testing unaligned reads.
    la t0, unaligned1
    ld t1, 0(t0)
    //prgchk reg t1 == 0xffffffffffffffffabcdef0123456789

    la t0, unaligned2
    ld t1, 0(t0)
    //prgchk reg t1 == 0xfffffffffffffffffedcba9876543210

    la t0, unaligned3
    ld t1, 0(t0)
    //prgchk reg t1 == 0xffffffffffffffffdeadbeefbeefdead

    la t0, unaligned4
    ld t1, 0(t0)
    //prgchk reg t1 == 0xffffffffffffffffcafebabebabecafe

    la t0, unaligned5
    ld t1, 0(t0)
    //prgchk reg t1 == 0xffffffffffffffffabadadddabcdabed

    la t0, unaligned6
    ld t1, 0(t0)
    //prgchk reg t1 == 0xffffffffffffffffeeffeeffeeffeeff

    la t0, unaligned7
    ld t1, 0(t0)
    //prgchk reg t1 == 0x00000000000000005879545963448eee

    j exit
