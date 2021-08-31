#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    liu(t0, 0xffffffffffffffff)
    //prgchk reg t0 == 0xffffffffffffffff

    slli(t1, t0, 64)
    or t1, t1, t0

    srai(t2, t1, 64)
    srai(t2, t2, 64)
    //prgcheck reg t2 == 0xffffffffffffffff

    // Check that a shift with 64-bit sign bit doesn't carry it (not a 64 bit srai).
    srai(t2, t0, 32)
    //prgchk reg t2 == 0xffffffff

    // Check that a shift with 32-bit sign bit doesn't carry it (not a 32-bit srai).
    li t0, 0xffffffff
    srai(t2, t0, 16)
    //prgchk reg t2 == 0xffff

    // Check max shift value, and carry of sign bit.
    //    Sign bit = 1
    li t0, 0x8000000000000000
    slli(t1, t0, 64)
    srai(t2, t1, 127)
    //prgchk reg t2 == 0xffffffffffffffff
    
    //    Sign bit = 0
    srli(t0, t0, 64)
    srli(t0, t0, 64)
    li t0, 0x7000000000000000
    slli(t1, t0, 64)
    srai(t2, t1, 127)
    //prgck reg t2 == 0
j exit