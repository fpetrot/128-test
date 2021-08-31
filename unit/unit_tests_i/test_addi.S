#include "insns.S" 
#include "utils.S"

.section .data
    test_quad: .octa 0x75033785b9ca9eec0ec94d28201e1869

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    // Add -1
    la t0, test_quad
    lq(t0, 0, t0)

    addi t1, t0, -1
    //prgchk reg t1 == 0x0ec94d28201e1868
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec

    // Test add zero = no-op
    addi t1, t0, 0
    //prgchk reg t1 == 0x0ec94d28201e1869
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec

    // Add max positive immediate value.
    addi t1, t0, 2047
    //prgchk reg t1 == 0x0ec94d28201e2068
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec
    
    // Add min negative immediate value.
    addi t1, t0, -2048
    //prgchk reg t1 == 0x0ec94d28201e1069
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec

    // Test add to x0 = no-op
    addi zero, t0, 42
    //prgchk reg zero == 0
    srli(t1, zero, 64)
    //prgchk reg t1 == 0

    // Test overflow into upper 64 bits.
    liu(t1, 0xffffffffffffffff)
    addi t2, t1, 1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 1
j exit