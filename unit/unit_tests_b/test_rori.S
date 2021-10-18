#include "insns.S" 
#include "utils.S"

.section .data
    test_quad: .octa 0x75033785b9ca9eec0ec94d28201e1869

.section .text.init,"ax",@progbits
.globl _start
_start:
    la t0, test_quad
    lq(t0, 0, t0)

    rori(t1, t0, 1)
    //prgchk reg t1 == 0x0764a694100f0c34
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x3a819bc2dce54f76
    j exit
