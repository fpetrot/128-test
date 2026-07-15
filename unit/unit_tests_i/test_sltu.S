#include "exit.S"

.section .data


.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check that comparison is really unsigned.
    li s0, -1
    li s1, 42
    sltu s2, s0, s1
    //prgchk reg s2 == 0


    // Test all five orderings of the words.
    li s0, 0xfedcba0987654321fedcba0987654321
    //prgchk reg s0 == 0xfedcba0987654321fedcba0987654321

    li s1, 0x1234567890abcdef1234567890abcdef
    //prgchk reg s1 == 0x1234567890abcdef1234567890abcdef
    
    sltu s2, s0, s1
    //prgchk reg s2 == 0



    li s0, 0x1234567890abcdeffedcba0987654321
    //prgchk reg s0 == 0x1234567890abcdeffedcba0987654321

    li s1, 0xfedcba09876543211234567890abcdef
    //prgchk reg s1 == 0xfedcba09876543211234567890abcdef
    
    sltu s2, s0, s1
    //prgchk reg s2 == 1



    li s0, 0x1234567890abcdef1234567890abcdef
    //prgchk reg s0 == 0x1234567890abcdef1234567890abcdef

    li s1, 0xfedcba0987654321fedcba0987654321
    //prgchk reg s1 == 0xfedcba0987654321fedcba0987654321
    
    sltu s2, s0, s1
    //prgchk reg s2 == 1



    li s0, 0xfedcba09876543211234567890abcdef
    //prgchk reg s0 == 0xfedcba09876543211234567890abcdef

    li s1, 0xfedcba0987654321fedcba0987654321
    //prgchk reg s1 == 0xfedcba0987654321fedcba0987654321
    
    sltu s2, s0, s1
    //prgchk reg s2 == 1


    li s0, 0xfedcba09876543211234567890abcdef
    //prgchk reg s0 == 0xfedcba09876543211234567890abcdef

    li s1, 0x1234567890abcdeffedcba0987654321
    //prgchk reg s1 == 0x1234567890abcdeffedcba0987654321
    
    sltu s2, s0, s1
    //prgchk reg s2 == 0

    j exit
