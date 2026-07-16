#include "exit.S"

.section .data
    .align 4
    .byte 0xde
    unaligned_1: .word 0xcafebabe
    .byte 0xad
    unaligned_2: .word 0x12345678
    .byte 0xbe
    unaligned_3: .word 0x87654321

.section .text.init,"ax",@progbits
.global _start
_start:
    la s1, unaligned_1
    lwu s1, 0(s1)
    //prgchk reg s1 == 0xcafebabe

    la s1, unaligned_2
    lwu s1, 0(s1)
    //prgchk reg s1 == 0x12345678

    la s1, unaligned_3
    lwu s1, 0(s1)
    //prgchk reg s1 == 0x87654321

    j exit
