#include "exit.S"

.section .data
    test_quad:  .octa 0x75033785b9ca9eec0ec94d28201e1869
    test_mask1: .octa 0x55555555555555555555555555555555
    test_mask2: .octa 0x12341234abcdabcd567856781234efef

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0x75033785b9ca9eec0ec94d28201e1869
    //prgchk reg s0 == 0x75033785b9ca9eec0ec94d28201e1869

    // or with -1 : set to -1
    li s1, -1
    or s1, s1, s0
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    // or with zero = no-op
    li s1, 0
    or s1, s0, s1
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1869
    
    // try a few 128-bit patterns
    li s1, 0x55555555555555555555555555555555
    //prgchk reg s1 == 0x55555555555555555555555555555555

    or s2, s1, s0
    //prgchk reg s2 == 0x755777d5fddfdffd5fdd5d7d755f5d7d

    li s1, 0x12341234abcdabcd567856781234efef
    //prgchk reg s1 == 0x12341234abcdabcd567856781234efef

    or s2, s1, s0
    //prgchk reg s2 == 0x773737b5bbcfbfed5ef95f78323effef
    j exit
