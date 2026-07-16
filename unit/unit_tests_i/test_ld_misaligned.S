#include "exit.S"

.section .data
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
    la s0, unaligned1
    ld s1, 0(s0)
    //prgchk reg s1 == 0xffffffffffffffffabcdef0123456789

    la s0, unaligned2
    ld s1, 0(s0)
    //prgchk reg s1 == 0xfffffffffffffffffedcba9876543210

    la s0, unaligned3
    ld s1, 0(s0)
    //prgchk reg s1 == 0xffffffffffffffffdeadbeefbeefdead

    la s0, unaligned4
    ld s1, 0(s0)
    //prgchk reg s1 == 0xffffffffffffffffcafebabebabecafe

    la s0, unaligned5
    ld s1, 0(s0)
    //prgchk reg s1 == 0xffffffffffffffffabadadddabcdabed

    la s0, unaligned6
    ld s1, 0(s0)
    //prgchk reg s1 == 0xffffffffffffffffeeffeeffeeffeeff

    la s0, unaligned7
    ld s1, 0(s0)
    //prgchk reg s1 == 0x00000000000000005879545963448eee

    j exit
