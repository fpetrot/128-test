#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check comparison is actually signed.
    li s0, -42
    bgez s0, all_err

    li s0, 0x53dadaf536d33cd841e0ce648ce00cfe
    bgez s0, 1f

    //prgchk err
    nop
1:
    li s0, 0x7719ac66eba267730000000000000014
    bgez s0, 1f

    //prgchk err
    nop
1:
    li s0, 0x9da1a0ce2cbdc61e0000000000000487
    bgez s0, all_err

    li s0, -1
    bgez s0, all_err

    li s0, 0
    bgez s0, 1f
    //prgchk err
    nop

1:  j exit

all_err:
    //prgchk err
    nop

