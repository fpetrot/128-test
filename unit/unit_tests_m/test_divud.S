#include "insns.S" 
#include "utils.S"

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
    divud s2, s0, s1
    //prgchk reg s2 == 0xd

    divud s2, s1, s0
    //prgchk reg s2 == 0

    ld s1, w3
    divud s2, s0, s1
    //prgchk reg s2 == 0x3dc8e74820d2baf
    
    // Divide by self.
    divud s2, s0, s0
    //prgchk reg s2 == 1

    // Divide by -1
    ld s0, w1
    ld s1, w5
    divud s2, s0, s1
    //prgchk reg s2 == 0

    ld s0, w4
    divud s2, s0, s1
    //prgchk reg s2 == 0

    ld s0, w6
    divud s2, s0, s1
    //prgchk reg s2 == 0

    // Check div by zero behavior
    ld s0, w1
    liu(s1, 0)
    divud s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff
    j exit
