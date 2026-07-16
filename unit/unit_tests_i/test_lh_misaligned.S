#include "exit.S"

.section .data
    .align 2
    .byte 0xde
    unaligned_1: .half 0x5341

.section .text.init,"ax",@progbits
.global _start
_start:
    la s1, unaligned_1
    lh s1, 0(s1)
    //prgchk reg s1 == 0x00000000000000000000000000005341

    j exit
