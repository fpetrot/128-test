#include "exit.S"

.section .data
    bigtest1:  .octa 0x53dadaf536d33cd841e0ce648ce00cfe
    bigtest2:  .octa 0x3c955c52adc10a460dc8a13fa3a7b2c7
    halftest1: .octa 0x7719ac66eba267730000000000000014
    halftest2: .octa 0x9da1a0ce2cbdc61e0000000000000487
    oftest1:   .octa 0x80000000000000000000000000000000
    oftest2:   .octa 1
    oftest3:   .octa 0x7fffffffffffffffffffffffffffffff
    oftest4:   .octa -1

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

    la s0, bigtest1
    lq s0, 0(s0)

    la s1, bigtest2
    lq s1, 0(s1)

    bge s1, s0, all_err

    bge s0, s1, after_tst2
    //prgchk err
    nop
after_tst2:

    // Compare with self
    la s1, bigtest1
    lq s1, 0(s1)
    bge s0, s1, after_tst22
    //prgchk err geq with self is not true
    nop
after_tst22:

    // Check comparison is on 128 bits.
    la s0, halftest1
    lq s0, 0(s0)

    la s1, halftest2
    lq s1, 0(s1)

    bge s0, s1, after_tst23
    //prgchk err
    nop
after_tst23:

    // Test with subtraction overflow (negative - positive -> positive)
    la s0, oftest1
    lq s0, 0(s0)

    la s1, oftest2
    lq s1, 0(s1)

    bge s0, s1, all_err

    // Test with subtraction overflow (positive - negative -> negative)
    la s0, oftest3
    lq s0, 0(s0)

    la s1, oftest4
    lq s1, 0(s1)

    bge s0, s1, after_tst3
    //prgchk err
    nop
after_tst3:
    // Check with 0, optimized path in codegen
    la s0, halftest1
    lq s0, 0(s0)
    bgez s0, 1f
    //prgchk err
    nop
1:
    la s0, halftest2
    lq s0, 0(s0)
    bgez s0, all_err
    j exit

all_err:
    //prgchk err
    nop
