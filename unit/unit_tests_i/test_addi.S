#include "exit.S"

.section .data
    test_quad: .octa 0x75033785b9ca9eec0ec94d28201e1869

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Add -1
    li s0, 0x75033785b9ca9eec0ec94d28201e1869
    //prgchk reg s0 == 0x75033785b9ca9eec0ec94d28201e1869

    addi s1, s0, -1
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1868

    // Test add zero = no-op
    addi s1, s0, 0
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1869

    // Add max positive immediate value.
    addi s1, s0, 2047
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e2068
    
    // Add min negative immediate value.
    addi s1, s0, -2048
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1069

    // Test add to x0 = no-op
    addi zero, s0, 42
    //prgchk reg zero == 0

    // Test overflow into upper 64 bits.
    li s1, 0x10000000000000000
    //prgchk reg s1 == 0x10000000000000000
    j exit
