#include "insns.S" 
#include "utils.S"

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
    sltu t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Test all five orderings of the words.
    la t0, tst1_1
    lq(t0, 0, t0)
    la t1, tst1_2
    lq(t1, 0, t1)
    
    sltu t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0


    la t0, tst2_1
    lq(t0, 0, t0)
    la t1, tst2_2
    lq(t1, 0, t1)
    
    sltu t2, t0, t1
    //prgchk reg t2 == 1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0


    la t0, tst3_1
    lq(t0, 0, t0)
    la t1, tst3_2
    lq(t1, 0, t1)
    
    sltu t2, t0, t1
    //prgchk reg t2 == 1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    la t0, tst4_1
    lq(t0, 0, t0)
    la t1, tst4_2
    lq(t1, 0, t1)
    
    sltu t2, t0, t1
    //prgchk reg t2 == 1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    la t0, tst5_1
    lq(t0, 0, t0)
    la t1, tst5_2
    lq(t1, 0, t1)
    
    sltu t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0
j exit