#include "exit.S"

.section .data
    test_quad:  .octa 0x75033785b9ca9eec0ec94d28201e1869
    test_neg:   .octa 0xd15d6ce86bb031505946fbf11b39add6
    test_mask1: .octa 0x55555555555555555555555555555555
    test_mask2: .octa 0x12341234abcdabcd567856781234efef
    mask_byte:  .octa 0xff
    mask_half:  .octa 0xffff
    mask_word:  .octa 0xffffffff
    mask_dword: .octa 0xffffffffffffffff
    mask_sign:  .octa 0x80000000000000000000000000000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    la t0, test_quad
    lq t0, 0(t0)

    // and with zero : movi 0
    li t1, 0
    and t1, t0, t1
    //prgchk reg t1 == 0x00000000000000000000000000000000

    // and with -1 : no-op
    li t1, -1
    and t1, t0, t1
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1869

    // various masks
    la t1, test_mask1
    lq t1, 0(t1)
    and t2, t0, t1
    //prgchk reg t2 == 0x55011505114014440441450000141041

    la t1, test_mask2
    lq t1, 0(t1)
    and t2, t0, t1
    //prgchk reg t2 == 0x10001204a9c88acc0648442800140869

    la t1, mask_byte
    lq t1, 0(t1)
    and t2, t0, t1
    //prgchk reg t2 == 0x00000000000000000000000000000069

    la t1, mask_half
    lq t1, 0(t1)
    and t2, t0, t1
    //prgchk reg t2 == 0x00000000000000000000000000001869

    la t1, mask_word
    lq t1, 0(t1)
    and t2, t0, t1
    //prgchk reg t2 == 0x000000000000000000000000201e1869

    la t1, mask_dword
    lq t1, 0(t1)
    and t2, t0, t1
    //prgchk reg t2 == 0x00000000000000000ec94d28201e1869

    la t1, mask_sign
    lq t1, 0(t1)
    and t2, t0, t1
    //prgchk reg t2 == 0x00000000000000000000000000000000

    la t0, test_neg
    lq t0, 0(t0)
    la t1, mask_sign
    lq t1, 0(t1)
    and t2, t0, t1
    //prgchk reg t2 == 0x80000000000000000000000000000000
    j exit
