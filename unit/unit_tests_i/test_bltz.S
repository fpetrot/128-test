#include "exit.S"

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
    li s0, -666
    bltz s0, 1f

    //prgchk err
    nop
1:
    // Check comparison is actually signed.
    li s0, 13
    bltz s0, all_err

    // Well, just the upper bit set
    la s0, oftest1
    lq s0, 0(s0)

    bltz s0, 1f

    //prgchk err
    nop
1:
    // Well, just the upper bit not set
    la s0, oftest3
    lq s0, 0(s0)

    bltz s0, all_err

    // Compare with zero, to finish with
    li s0, 0
    bltz s0, all_err

    j exit

all_err:
    //prgchk err
    nop
