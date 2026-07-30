#include "exit.S"

.section .data
    test_quad: .octa 0x75033785b9ca9eec0ec94d28201e1869

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0x75033785b9ca9eec0ec94d28201e1869

    rori s1, s0, 1
    //prgchk reg s1 == 0x3a819bc2dce54f760764a694100f0c34
    j exit
