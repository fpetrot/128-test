#include "utils.S"

.section .data
    test_quad:  .octa 0x75033785b9ca9eec0ec94d28201e1869
    test_mask1: .octa 0x55555555555555555555555555555555
    test_mask2: .octa 0x12341234abcdabcd567856781234efef

.section .text.init,"ax",@progbits
.globl _start
_start:
    la t0, test_quad
    lq t0, 0(t0)

    // or with -1 : set to -1
    li t1, -1
    or t1, t1, t0
    //prgchk reg t1 == 0xffffffffffffffffffffffffffffffff

    // or with zero = no-op
    li t1, 0
    or t1, t0, t1
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1869
    
    // try a few 128-bit patterns
    la t1, test_mask1
    lq t1, 0(t1)

    or t2, t1, t0
    //prgchk reg t2 == 0x755777d5fddfdffd5fdd5d7d755f5d7d

    la t1, test_mask2
    lq t1, 0(t1)

    or t2, t1, t0
    //prgchk reg t2 == 0x773737b5bbcfbfed5ef95f78323effef
    j exit
