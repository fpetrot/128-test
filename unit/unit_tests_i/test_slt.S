#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check comparison is actually signed.
    li s0, -42
    li s1, 42
    slt s2, s0, s1
    //prgchk reg s2 == 1

    li s0, 0x53dadaf536d33cd841e0ce648ce00cfe
    //prgchk reg s0 == 0x53dadaf536d33cd841e0ce648ce00cfe

    li s1, 0x3c955c52adc10a460dc8a13fa3a7b2c7
    //prgchk reg s1 == 0x3c955c52adc10a460dc8a13fa3a7b2c7

    slt s2, s0, s1
    //prgchk reg s2 == 0

    slt s2, s1, s0
    //prgchk reg s2 == 1

    // Compare with self
    li s1, 0x53dadaf536d33cd841e0ce648ce00cfe
    //prgchk reg s1 == 0x53dadaf536d33cd841e0ce648ce00cfe
    slt s2, s1, s1
    //prgchk reg s2 == 0


    // Check comparison is on 128 bits.
    li s0, 0x7719ac66eba267730000000000000355
    //prgchk reg s0 == 0x7719ac66eba267730000000000000355

    li s1, 0x9da1a0ce2cbdc61e0000000000000058
    //prgchk reg s1 == 0x9da1a0ce2cbdc61e0000000000000058

    slt s2, s0, s1
    //prgchk reg s2 == 0


    // Test with subtraction overflow (negative - positive -> positive)
    li s0, 0x80000000000000000000000000000000
    //prgchk reg s0 == 0x80000000000000000000000000000000

    li s1, 1
    //prgchk reg s1 == 0x1

    slt s2, s0, s1
    //prgchk reg s2 == 1


    // Test with subtraction overflow (positive - negative -> negative)
    li s0, 0x7fffffffffffffffffffffffffffffff
    //prgchk reg s0 == 0x7fffffffffffffffffffffffffffffff

    li s1, -1
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    slt s2, s0, s1
    //prgchk reg s2 == 0

    j exit
