#include "insns.S" 
#include "utils.S"

    .section .data
val:.octa 0x112233445566778899aabbccddeeff00
lav:.octa 0x0
vd :.octa 0x77777777777777777777777777777777
vw :.octa 0x77777777777777777777777777777777
vh :.octa 0x77777777777777777777777777777777
vb :.octa 0x77777777777777777777777777777777

    .section .text.init,"ax",@progbits
    .global _start
_start:
    # We're in bare metal, so set stack at the end of physical memory
    la      sp, _memory_end
    j main
# Intermediate checks => all insns but loads and stores still act on 64-bit
# registers!
main:
    # Quad load
    la t0, val
    la t2, lav
    lq(t1, 0, t0)
    sq(t1, 0, t2)
    la t2, vd
    sd t1, 0(t2)
    la t2, vw
    sw t1, 0(t2)
    la t2, vh
    sh t1, 0(t2)
    la t2, vb
    sb t1, 0(t2)
    j exit
