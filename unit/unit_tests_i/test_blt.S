#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check comparison is actually signed.
    li s0, -42
    li s1, 42
    blt s0, s1, after_tst1

    //prgchk err
    nop
after_tst1:

    li s0, 0x53dadaf536d33cd841e0ce648ce00cfe
    li s1, 0x3c955c52adc10a460dc8a13fa3a7b2c7

    blt s0, s1, all_err

    blt s1, s0, after_tst2
    //prgchk err
    nop
after_tst2:

    // Compare with self
    li s0, 0x53dadaf536d33cd841e0ce648ce00cfe
    li s1, 0x53dadaf536d33cd841e0ce648ce00cfe
    blt s0, s1, all_err

    // Check comparison is on 128 bits.
    li s0, 0x7719ac66eba267730000000000000355
    li s1, 0x9da1a0ce2cbdc61e0000000000000058

    blt s0, s1, all_err

    // Test with subtraction overflow (negative - positive -> positive)
    li s0, 0x80000000000000000000000000000000
    li s1, 1

    blt s0, s1, after_tst3

    //prgchk err
    nop
after_tst3:

    // Test with subtraction overflow (positive - negative -> negative)
    li s0, 0x7fffffffffffffffffffffffffffffff
    li s1, -1

    blt s0, s1, all_err

    // Comparison with zero, to check the optimized path in tcg generation
    li s1, 0x9da1a0ce2cbdc61e0000000000000058

    bltz s1, 1f
    //prgchk err
    nop
1:  
    li s1, 0x7719ac66eba267730000000000000355
    bltz s1, all_err

    j exit

all_err:
    //prgchk err
    nop
