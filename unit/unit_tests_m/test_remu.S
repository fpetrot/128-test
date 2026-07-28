#include "utils.S"
#include "exit.S"

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

    remu s2, s0, s1
    //prgchk reg s2 == 0x40ff7b18ad49488b569a

    // Div by one.
    li s1, 1
    remu s2, s0, s1
    //prgchk reg s2 == 0

    // Div by self.
    remu s2, s0, s0
    //prgchk reg s2 == 0

    // Divisor > Dividend
    la s0, big3
    lq s0, 0(s0)

    la s1, big4
    lq s1, 0(s1)

    remu s2, s0, s1
    //prgchk reg s2 == 0x2d7154484023d549a213226c599ce3b

    // Simple small division (no remainder)
    liu(s0, 21)
    liu(s1, 3)
    remu s2, s0, s1
    //prgchk reg s2 == 0

    liu(s0, 37)
    liu(s1, 5)
    remu s2, s0, s1
    //prgchk reg s2 == 2

    // Check different divisor sizes
    la s0, big4
    lq s0, 0(s0)

    la s1, div1
    lq s1, 0(s1)
    remu s2, s0, s1
    //prgchk reg s2 == 0x69531fa0

    la s1, div2
    lq s1, 0(s1)
    remu s2, s0, s1
    //prgchk reg s2 == 0x492deca597a8fc57

    la s1, div3
    lq s1, 0(s1)
    remu s2, s0, s1
    //prgchk reg s2 == 0x2fda5492790fff455a8b7fa

    la s1, div4
    lq s1, 0(s1)
    remu s2, s0, s1
    //prgchk reg s2 == 0x47d9102172350ae94cfd9075740a9934

    // Check div by zero behavior
    liu(s1, 0)
    remu s2, s0, s1
    //prgchk reg s2 == 0xcf3e53431e02fa946034e4b6c81ebfcc
    j exit
