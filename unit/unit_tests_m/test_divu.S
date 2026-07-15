#include "insns.S" 
#include "utils.S"

.section .data
    big1: .octa 0x7c4574e203312d7c2eccfc6e195e28ec
    big2: .octa 0x123456789abcdefabcdef
    big3: .octa 0x2d7154484023d549a213226c599ce3b
    big4: .octa 0xcf3e53431e02fa946034e4b6c81ebfcc

    div1: .octa 0x000000000000000000000000abcdef12
    div2: .octa 0x0000000000000000fedcba0987654321
    div3: .octa 0x000000001234567842434546787541fe
    div4: .octa 0x87654321abcdefab1337544154142698

.section .text.init,"ax",@progbits
.global _start
_start:
    la s0, big1
     lq s0, 0(s0)

    la s1, big2
     lq s1, 0(s1)

    divu s2, s0, s1
    //prgchk reg s2 == 0x6d390bbaa4ce
 
    // Div by one.
    li s1, 1
    divu s2, s0, s1
    //prgchk reg s2 == 0x7c4574e203312d7c2eccfc6e195e28ec

    // Div by self.
    divu s2, s0, s0
    //prgchk reg s2 == 1
 
    // Divison > Dividend
    la s0, big3
     lq s0, 0(s0)

    la s1, big4
     lq s1, 0(s1)

    divu s2, s0, s1
    //prgchk reg s2 == 0
 
    // Simple small division (no remainder)
    liu(s0, 21)
    liu(s1, 3)
    divu s2, s0, s1
    //prgchk reg s2 == 7
 
    liu(s0, 37)
    liu(s1, 5)
    divu s2, s0, s1
    //prgchk reg s2 == 7
 
    // Chek different divisor sizes
    la s0, big4
     lq s0, 0(s0)

    la s1, div1
     lq s1, 0(s1)
    divu s2, s0, s1
    //prgchk reg s2 == 0x134ce77156495d65af81253e6
    srli(s2, s2, 64)
    //prgchk reg s2 == 0x

    la s1, div2
     lq s1, 0(s1)
    divu s2, s0, s1
    //prgchk reg s2 == 0xd02b2d3b9780c9d5
 
    la s1, div3
    lq s1, 0(s1)
    divu s2, s0, s1
    //prgchk reg s2 == 0xb625c7317
 
    la s1, div4
    lq s1, 0(s1)
    divu s2, s0, s1
    //prgchk reg s2 == 1
 
    // Check div by zero behavior
    liu(s1, 0)
    divu s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff
    j exit
