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

    minsgn: .octa 0x80000000000000000000000000000000
    minone: .octa 0xffffffffffffffffffffffffffffffff

.section .text.init,"ax",@progbits
.global _start
_start:
    la s0, big1
    lq s0, 0(s0)

    la s1, big2
    lq s1, 0(s1)

    rem s2, s0, s1
    //prgchk reg s2 == 0x40ff7b18ad49488b569a

    // Check trucature towards 0
    li s0, 3
    li s1, -2
    rem s2, s0, s1
    //prgchk reg s2 == 1

    // Check signedness of division.
    li s0, -2048
    li s1, -1
    rem s2, s0, s1
    //prgchk reg s2 == 0

    // Check different divisor sizes
    lqg(s0, big4)

    lqg(s1, div1)
    rem s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffff9fb7bfc2

    lqg(s1, div2)
    rem s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffff0241c351efac54ae

    lqg(s1, div3)
    rem s2, s0, s1
    //prgchk reg s2 == 0xfffffffffcb69b69bf6056b034ce3f72

    lqg(s1, div4)
    rem s2, s0, s1
    //prgchk reg s2 == 0xcf3e53431e02fa946034e4b6c81ebfcc

    // Check div by zero behavior
    liu(s1, 0)
    rem s2, s0, s1
    //prgchk reg s2 == 0xcf3e53431e02fa946034e4b6c81ebfcc

    // Check overflow behavior.
    lqg(s0, minsgn)
    lqg(s1, minone)
    rem s2, s0, s1
    //prgchk reg s2 == 0
    j exit
