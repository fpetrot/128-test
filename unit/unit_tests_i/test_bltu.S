#include "exit.S"

.section .data
    tst1_1:  .octa 0xfedcba0987654321fedcba0987654321
    tst1_2:  .octa 0x1234567890abcdef1234567890abcdef
    tst2_1:  .octa 0x1234567890abcdeffedcba0987654321
    tst2_2:  .octa 0xfedcba09876543211234567890abcdef
    tst3_1:  .octa 0x1234567890abcdef1234567890abcdef
    tst3_2:  .octa 0xfedcba0987654321fedcba0987654321
    tst4_1:  .octa 0xfedcba09876543211234567890abcdef
    tst4_2:  .octa 0xfedcba0987654321fedcba0987654321
    tst5_1:  .octa 0xfedcba09876543211234567890abcdef
    tst5_2:  .octa 0x1234567890abcdeffedcba0987654321


.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check that comparison is really unsigned.
    li s0, -1
    li s1, 42
    bltu s0, s1, all_err

    // Test all five orderings of the words.
    li s0, 0xfedcba0987654321fedcba0987654321
    li s1, 0x1234567890abcdef1234567890abcdef
    
    bltu s0, s1, all_err

    li s0, 0x1234567890abcdeffedcba0987654321
    li s1, 0xfedcba09876543211234567890abcdef
    
    bltu s0, s1, after_tst1
    //prgchk err
    nop
after_tst1:

    li s0, 0x1234567890abcdef1234567890abcdef
    li s1, 0xfedcba0987654321fedcba0987654321
    
    bltu s0, s1, after_tst2
    //prgchk err
    nop
after_tst2:

    li s0, 0xfedcba09876543211234567890abcdef
    li s1, 0xfedcba0987654321fedcba0987654321
    
    bltu s0, s1, after_tst3
    //prgchk err
    nop
after_tst3:

    li s0, 0xfedcba09876543211234567890abcdef
    li s1, 0x1234567890abcdeffedcba0987654321
    
    bltu s0, s1, all_err
    j exit

all_err:
    //prgchk err
    nop
