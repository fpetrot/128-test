#include "exit.S"


.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check comparison is actually signed.
    li s0, -42
    li s1, 42
    bge s1, s0, after_tst1

    //prgchk err
    nop
after_tst1:

    # bigtest1
    li s0, 0x53dadaf536d33cd841e0ce648ce00cfe

    # bigtest2
    li s1, 0x3c955c52adc10a460dc8a13fa3a7b2c7

    bge s1, s0, all_err

    bge s0, s1, after_tst2
    //prgchk err
    nop
after_tst2:

    // Compare with self
    li s1, 0x53dadaf536d33cd841e0ce648ce00cfe
    li s0, 0x53dadaf536d33cd841e0ce648ce00cfe
    bge s0, s1, after_tst22
    //prgchk err geq with self is not true
    nop
after_tst22:

    // Check comparison is on 128 bits.
    li s0, 0x7719ac66eba267730000000000000014

    li s1, 0x9da1a0ce2cbdc61e0000000000000487

    bge s0, s1, after_tst23
    //prgchk err
    nop
after_tst23:

    // Test with subtraction overflow (negative - positive -> positive)
    li s0, 0x80000000000000000000000000000000
    li s1, 1

    bge s0, s1, all_err

    // Test with subtraction overflow (positive - negative -> negative)
    li s0, 0x7fffffffffffffffffffffffffffffff
    li s1, -1

    bge s0, s1, after_tst3
    //prgchk err
    nop
after_tst3:
    // Check with 0, optimized path in codegen
    li s0, 0x7719ac66eba267730000000000000014
    bgez s0, 1f
    //prgchk err
    nop
1:
    li s0, 0x9da1a0ce2cbdc61e0000000000000487
    bgez s0, all_err
    j exit

all_err:
    //prgchk err
    nop
