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
    li t0, -1
    li t1, 42
    bltu t0, t1, all_err

    // Test all five orderings of the words.
    la t0, tst1_1
    lq t0, 0(t0)
    la t1, tst1_2
    lq t1, 0(t1)
    
    bltu t0, t1, all_err

    la t0, tst2_1
    lq t0, 0(t0)
    la t1, tst2_2
    lq t1, 0(t1)
    
    bltu t0, t1, after_tst1
    //prgchk err
    nop
after_tst1:

    la t0, tst3_1
    lq t0, 0(t0)
    la t1, tst3_2
    lq t1, 0(t1)
    
    bltu t0, t1, after_tst2
    //prgchk err
    nop
after_tst2:

    la t0, tst4_1
    lq t0, 0(t0)
    la t1, tst4_2
    lq t1, 0(t1)
    
    bltu t0, t1, after_tst3
    //prgchk err
    nop
after_tst3:

    la t0, tst5_1
    lq t0, 0(t0)
    la t1, tst5_2
    lq t1, 0(t1)
    
    bltu t0, t1, all_err
    j exit

all_err:
    //prgchk err
    nop
