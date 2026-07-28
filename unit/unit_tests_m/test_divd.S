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
    divd s2, s0, s1
    //prgchk reg s2 == 0


    divd s2, s1, s0
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffff1


    ld s1, w3
    divd s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffb963672894ab7

    
    // Divide by self.
    divd s2, s0, s0
    //prgchk reg s2 == 1


    // Divide by -1
    ld s0, w1
    ld s1, w5
    divd s2, s0, s1
    //prgchk reg s2 == 0x012345f6789abcdf


    ld s0, w4
    divd s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffff87698bae77ab8bef


    ld s0, w6
    divd s2, s0, s1
    //prgchk reg s2 == 42


    // Check overflow behavior.
    ld s0, minsgn
    ld s1, w5
    divd s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffff8000000000000000


    // Check div by zero behavior
    ld s0, w1
    liu(s1, 0)
    divd s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    j exit
