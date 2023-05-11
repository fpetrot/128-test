#include "insns.S" 
#include "utils.S"
.section .data
stacklq: .octa 0xd0000000000000000000000000000001
         .octa 0xe0000000000000000000000000000002
         .octa 0xa0000000000000000000000000000003
         .octa 0xd0000000000000000000000000000004
         .octa 0xb0000000000000000000000000000005
         .octa 0xe0000000000000000000000000000006
         .octa 0xe0000000000000000000000000000007
         .octa 0xf0000000000000000000000000000008
         .octa 0xc0000000000000000000000000000009
         .octa 0xa000000000000000000000000000000a
         .octa 0xf000000000000000000000000000000b
         .octa 0xe000000000000000000000000000000c
         .octa 0xb000000000000000000000000000000d
         .octa 0xa000000000000000000000000000000e
         .octa 0xb000000000000000000000000000000f
         .octa 0xe0000000000000000000000000000000
stacksq: .octa 0xdffffffffffffffffffffffffffffff1
         .octa 0xeffffffffffffffffffffffffffffff2
         .octa 0xaffffffffffffffffffffffffffffff3
         .octa 0xdffffffffffffffffffffffffffffff4
         .octa 0xbffffffffffffffffffffffffffffff5
         .octa 0xeffffffffffffffffffffffffffffff6
         .octa 0xeffffffffffffffffffffffffffffff7
         .octa 0xfffffffffffffffffffffffffffffff8
         .octa 0xcffffffffffffffffffffffffffffff9
         .octa 0xaffffffffffffffffffffffffffffffa
         .octa 0xfffffffffffffffffffffffffffffffb
         .octa 0xeffffffffffffffffffffffffffffffc
         .octa 0xbffffffffffffffffffffffffffffffd
         .octa 0xaffffffffffffffffffffffffffffffe
         .octa 0xbfffffffffffffffffffffffffffffff
         .octa 0xeffffffffffffffffffffffffffffff0

.section .text.init,"ax",@progbits
.globl _start
_start:
    /* load stuff and check */
    la   sp, stacklq
    lqsp(r5, 0x00)
    //prgchk reg x5 == 0x0000000000000001
    srli(x4, x5, 64)
    //prgchk reg x4 == 0xd000000000000000
    lqsp(r6, 0x10)
    //prgchk reg x6 == 0x0000000000000002
    srli(x4, x6, 64)
    //prgchk reg x4 == 0xe000000000000000
    lqsp(r7, 0x20)
    //prgchk reg x7 == 0x0000000000000003
    srli(x4, x7, 64)
    //prgchk reg x4 == 0xa000000000000000
    lqsp(r8, 0x30)
    //prgchk reg x8 == 0x0000000000000004
    srli(x4, x8, 64)
    //prgchk reg x4 == 0xd000000000000000
    lqsp(r9, 0x40)
    //prgchk reg x9 == 0x0000000000000005
    srli(x4, x9, 64)
    //prgchk reg x4 == 0xb000000000000000
    lqsp(r10, 0x50)
    //prgchk reg x10 == 0x0000000000000006
    srli(x4, x10, 64)
    //prgchk reg x4 == 0xe000000000000000
    lqsp(r11, 0x60)
    //prgchk reg x11 == 0x0000000000000007
    srli(x4, x11, 64)
    //prgchk reg x4 == 0xe000000000000000
    lqsp(r12, 0x70)
    //prgchk reg x12 == 0x0000000000000008
    srli(x4, x12, 64)
    //prgchk reg x4 == 0xf000000000000000
    lqsp(r13, 0x80)
    //prgchk reg x13 == 0x0000000000000009
    srli(x4, x13, 64)
    //prgchk reg x4 == 0xc000000000000000
    lqsp(r14, 0x90)
    //prgchk reg x14 == 0x000000000000000a
    srli(x4, x14, 64)
    //prgchk reg x4 == 0xa000000000000000
    lqsp(r15, 0xa0)
    //prgchk reg x15 == 0x000000000000000b
    srli(x4, x15, 64)
    //prgchk reg x4 == 0xf000000000000000
    lqsp(r16, 0xb0)
    //prgchk reg x16 == 0x000000000000000c
    srli(x4, x16, 64)
    //prgchk reg x4 == 0xe000000000000000
    lqsp(r17, 0xc0)
    //prgchk reg x17 == 0x000000000000000d
    srli(x4, x17, 64)
    //prgchk reg x4 == 0xb000000000000000
    lqsp(r18, 0xd0)
    //prgchk reg x18 == 0x000000000000000e
    srli(x4, x18, 64)
    //prgchk reg x4 == 0xa000000000000000
    lqsp(r19, 0xe0)
    //prgchk reg x19 == 0x000000000000000f
    srli(x4, x19, 64)
    //prgchk reg x4 == 0xb000000000000000
    lqsp(r20, 0xf0)
    //prgchk reg x20 == 0x0000000000000000
    srli(x4, x20, 64)
    //prgchk reg x4 == 0xe000000000000000

    /* save stuff and check */
    la   sp, stacksq
    sqsp(r5, 0x00)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x00) == 0x0000000000000001
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x08) == 0xd000000000000000
    sqsp(r6, 0x10)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x10) == 0x0000000000000002
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x18) == 0xe000000000000000
    sqsp(r7, 0x20)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x20) == 0x0000000000000003
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x28) == 0xa000000000000000
    sqsp(r8, 0x30)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x30) == 0x0000000000000004
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x38) == 0xd000000000000000
    sqsp(r9, 0x40)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x40) == 0x0000000000000005
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x48) == 0xb000000000000000
    sqsp(r10, 0x50)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x50) == 0x0000000000000006
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x58) == 0xe000000000000000
    sqsp(r11, 0x60)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x60) == 0x0000000000000007
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x68) == 0xe000000000000000
    sqsp(r12, 0x70)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x70) == 0x0000000000000008
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x78) == 0xf000000000000000
    sqsp(r13, 0x80)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x80) == 0x0000000000000009
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x88) == 0xc000000000000000
    sqsp(r14, 0x90)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x90) == 0x000000000000000a
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0x98) == 0xa000000000000000
    sqsp(r15, 0xa0)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xa0) == 0x000000000000000b
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xa8) == 0xf000000000000000
    sqsp(r16, 0xb0)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xb0) == 0x000000000000000c
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xb8) == 0xe000000000000000
    sqsp(r17, 0xc0)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xc0) == 0x000000000000000d
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xc8) == 0xb000000000000000
    sqsp(r18, 0xd0)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xd0) == 0x000000000000000e
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xd8) == 0xa000000000000000
    sqsp(r19, 0xe0)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xe0) == 0x000000000000000f
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xe8) == 0xb000000000000000
    sqsp(r20, 0xf0)
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xf0) == 0x0000000000000000
    //prgchk gdb *(unsigned long *)((void *)&stacksq + 0xf8) == 0xe000000000000000
    j exit
