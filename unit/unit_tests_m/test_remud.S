#include "utils.S"
#include "exit.S"

.section .rodata
    w1:     .dword 0xfedcba0987654321
    w2:     .dword 0x1234567890abcdef
    w3:     .dword 0x42
    w4:     .dword 0x7896745188547411
    w5:     .dword 0xffffffffffffffff
    w6:     .dword 0xffffffffffffffd6
    minsgn: .dword 0x8000000000000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Various basic divisions
    ld s0, w1
    ld s1, w2
    remud s2, s0, s1
    //prgchk reg s2 == 0x123455ea2eabcdfe

    remud s2, s1, s0
    //prgchk reg s2 == 0x1234567890abcdef

    ld s1, w3
    remud s2, s0, s1
    //prgchk reg s2 == 3

    // Divide by self.
    remud s2, s0, s0
    //prgchk reg s2 == 0

    // Divide by -1
    ld s0, w1
    ld s1, w5
    remud s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffedcba0987654321

    ld s0, w4
    remud s2, s0, s1
    //prgchk reg s2 == 0x7896745188547411

    ld s0, w6
    remud s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffd6

    // Check div by zero behavior
    ld s0, w1
    liu(s1, 0)
    remud s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffedcba0987654321
    j exit
