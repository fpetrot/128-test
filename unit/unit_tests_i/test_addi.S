#include "insns.S" 
#include "utils.S"

.section .data
    test_quad: .octa 0x75033785b9ca9eec0ec94d28201e1869

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Add -1
    la t0, test_quad
    lq t0, 0(t0)

    addi t1, t0, -1
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1868

    // Test add zero = no-op
    addi t1, t0, 0
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1869

    // Add max positive immediate value.
    addi t1, t0, 2047
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e2068
    
    // Add min negative immediate value.
    addi t1, t0, -2048
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1069

    // Test add to x0 = no-op
    addi zero, t0, 42
    //prgchk reg zero == 0

    // Test overflow into upper 64 bits.
    liu(t1, 0x10000000000000000)
    //prgchk reg t1 == 0x10000000000000000
    j exit
