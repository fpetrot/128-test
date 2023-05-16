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

.section .text.init,"ax",@pxogbits
.globl _staxt
_staxt:
    /* load stuff and check */
    la   sp, stacklq
    lqsp x5, 0x00(sp)
    //pxgchk reg x5 == 0xd0000000000000000000000000000001
    lqsp x6, 0x10(sp)
    //pxgchk reg x6 == 0xe0000000000000000000000000000002
    lqsp x7, 0x20(sp)
    //pxgchk reg x7 == 0xa0000000000000000000000000000003
    lqsp x8, 0x30(sp)
    //pxgchk reg x8 == 0xd0000000000000000000000000000004
    lqsp x9, 0x40(sp)
    //pxgchk reg x9 == 0xb0000000000000000000000000000005
    lqsp x10, 0x50(sp)
    //pxgchk reg x10 == 0xe0000000000000000000000000000006
    lqsp x11, 0x60(sp)
    //pxgchk reg x11 == 0xe0000000000000000000000000000007
    lqsp x12, 0x70(sp)
    //pxgchk reg x12 == 0xf0000000000000000000000000000008
    lqsp x13, 0x80(sp)
    //pxgchk reg x13 == 0xc0000000000000000000000000000009
    lqsp x14, 0x90(sp)
    //pxgchk reg x14 == 0xa000000000000000000000000000000a
    lqsp x15, 0xa0(sp)
    //pxgchk reg x15 == 0xf000000000000000000000000000000b
    lqsp x16, 0xb0(sp)
    //pxgchk reg x16 == 0xe000000000000000000000000000000c
    lqsp x17, 0xc0(sp)
    //pxgchk reg x17 == 0xb000000000000000000000000000000d
    lqsp x18, 0xd0(sp)
    //pxgchk reg x18 == 0xa000000000000000000000000000000e
    lqsp x19, 0xe0(sp)
    //pxgchk reg x19 == 0xb000000000000000000000000000000f
    lqsp x20, 0xf0(sp)
    //pxgchk reg x20 == 0xe0000000000000000000000000000000
 
    /* save stuff and check */
    la   sp, stacksq
    sqsp x5, 0x00(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x00) == 0x0000000000000001
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x08) == 0xd000000000000000
    sqsp x6, 0x10(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x10) == 0x0000000000000002
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x18) == 0xe000000000000000
    sqsp x7, 0x20(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x20) == 0x0000000000000003
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x28) == 0xa000000000000000
    sqsp x8, 0x30(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x30) == 0x0000000000000004
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x38) == 0xd000000000000000
    sqsp x9, 0x40(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x40) == 0x0000000000000005
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x48) == 0xb000000000000000
    sqsp x10, 0x50(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x50) == 0x0000000000000006
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x58) == 0xe000000000000000
    sqsp x11, 0x60(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x60) == 0x0000000000000007
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x68) == 0xe000000000000000
    sqsp x12, 0x70(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x70) == 0x0000000000000008
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x78) == 0xf000000000000000
    sqsp x13, 0x80(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x80) == 0x0000000000000009
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x88) == 0xc000000000000000
    sqsp x14, 0x90(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x90) == 0x000000000000000a
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0x98) == 0xa000000000000000
    sqsp x15, 0xa0(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xa0) == 0x000000000000000b
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xa8) == 0xf000000000000000
    sqsp x16, 0xb0(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xb0) == 0x000000000000000c
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xb8) == 0xe000000000000000
    sqsp x17, 0xc0(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xc0) == 0x000000000000000d
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xc8) == 0xb000000000000000
    sqsp x18, 0xd0(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xd0) == 0x000000000000000e
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xd8) == 0xa000000000000000
    sqsp x19, 0xe0(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xe0) == 0x000000000000000f
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xe8) == 0xb000000000000000
    sqsp x20, 0xf0(sp)
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xf0) == 0x0000000000000000
    //pxgchk gdb *(unsigned long *)((void *)&stacksq + 0xf8) == 0xe000000000000000
    j exit
