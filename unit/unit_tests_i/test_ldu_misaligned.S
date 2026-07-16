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
    unaligned5: .dword 0xabcdabcdabcdabcd
    .byte 0xff
    unaligned6: .dword 0xeeffeeffeeffeeff
    .byte 0xff
    unaligned7: .dword 0x4242424242424242

.section .text.init,"ax",@progbits
.global _start
_start:
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
