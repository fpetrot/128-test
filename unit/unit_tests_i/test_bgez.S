#include "insns.S" 
#include "utils.S"

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
    li t0, -42
    bgez t0, all_err

    la t0, bigtest1
    lq t0, 0(t0)

    bgez t0, 1f
    //prgchk err
    nop
1:
    la t0, halftest1
    lq t0, 0(t0)

    bgez t0, 1f
    //prgchk err
    nop
1:
    la t0, halftest2
    lq t0, 0(t0)

    bgez t0, all_err

    la t0, oftest4
    lq t0, 0(t0)

    bgez t0, all_err

    li t0, 0
    bgez t0, 1f
    //prgchk err
    nop

1:  j exit

all_err:
    //prgchk err
    nop

