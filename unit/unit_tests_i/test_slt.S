#include "insns.S" 
#include "utils.S"

.section .data
    bigtest1:  .octa 0x53dadaf536d33cd841e0ce648ce00cfe
    bigtest2:  .octa 0x3c955c52adc10a460dc8a13fa3a7b2c7
    halftest1: .octa 0x7719ac66eba267730000000000000355
    halftest2: .octa 0x9da1a0ce2cbdc61e0000000000000058
    oftest1:   .octa 0x80000000000000000000000000000000
    oftest2:   .octa 1
    oftest3:   .octa 0x7fffffffffffffffffffffffffffffff
    oftest4:   .octa -1

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check comparison is actually signed.
    li t0, -42
    li t1, 42
    slt t2, t0, t1
    //prgchk reg t2 == 1

    la t0, bigtest1
    lq t0, 0(t0)

    la t1, bigtest2
    lq t1, 0(t1)

    slt t2, t0, t1
    //prgchk reg t2 == 0

    slt t2, t1, t0
    //prgchk reg t2 == 1

    // Compare with self
    la t1, bigtest1
    lq t1, 0(t1)
    //prgchk reg t2 == 0


    // Check comparison is on 128 bits.
    la t0, halftest1
    lq t0, 0(t0)

    la t1, halftest2
    lq t1, 0(t1)

    slt t2, t0, t1
    //prgchk reg t2 == 0


    // Test with subtraction overflow (negative - positive -> positive)
    la t0, oftest1
    lq t0, 0(t0)

    la t1, oftest2
    lq t1, 0(t1)

    slt t2, t0, t1
    //prgchk reg t2 == 1


    // Test with subtraction overflow (positive - negative -> negative)
    la t0, oftest3
    lq t0, 0(t0)

    la t1, oftest4
    lq t1, 0(t1)

    slt t2, t0, t1
    //prgchk reg t2 == 0

    j exit
