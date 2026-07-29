#include "exit.S"


.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check that comparison is really unsigned.
    li s0, -1
    li s1, 42
    bgeu s0, s1, after_tst1
    //prgchk err
    nop
after_tst1:

    // Test all five orderings of the words.
    li s0, 0xfedcba0987654321fedcba0987654321
    li s1, 0x1234567890abcdef1234567890abcdef
    
    bgeu s0, s1, after_tst2
    //prgchk err
    nop
after_tst2:

    li s0, 0x1234567890abcdeffedcba0987654321
    li s1, 0xfedcba09876543211234567890abcdef
    
    bgeu s0, s1, all_err

    li s0, 0x1234567890abcdef1234567890abcdef
    li s1, 0xfedcba0987654321fedcba0987654321
    
    bgeu s0, s1, all_err

    li s0, 0xfedcba09876543211234567890abcdef
    li s1, 0xfedcba0987654321fedcba0987654321
    
    bgeu s0, s1, all_err

    li s0, 0xfedcba09876543211234567890abcdef
    li s1, 0x1234567890abcdeffedcba0987654321
    
    bgeu s0, s1, after_tst3
    //prgchk err
    nop
after_tst3:
    j exit

all_err:
    //prgchk err
    nop
