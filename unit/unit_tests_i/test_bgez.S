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
    bgez s0, all_err

    la s0, bigtest1
    lq s0, 0(s0)

    bgez s0, 1f
    //prgchk err
    nop
1:
    la s0, halftest1
    lq s0, 0(s0)

    bgez s0, 1f
    //prgchk err
    nop
1:
    la s0, halftest2
    lq s0, 0(s0)

    bgez s0, all_err

    la s0, oftest4
    lq s0, 0(s0)

    bgez s0, all_err

    li s0, 0
    bgez s0, 1f
    //prgchk err
    nop

1:  j exit

all_err:
    //prgchk err
    nop

