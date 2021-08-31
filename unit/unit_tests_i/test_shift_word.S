#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    // --- SLLIW
    liu(t0, 0xffffffff)
    
    // Check sign extend to 64 bits.
    slliw t0, t0, 31
    //prgchk reg t0 == 0xffffffff80000000
    // Check sign extend to 128 bits
    srli(t1, t0, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    slliw t0, t0, 1
    //prgchk reg t0 == 0

    // --- SRLIW
    liu(t0, 0xffffffff)
    
    srliw t1, t0, 4
    //prgchk reg t1 == 0x000000000fffffff

    liu(t0, 0x80000000)
    //prgchk reg t0 == 0x80000000
    srliw t1, t0, 0
    //prgchk reg t1 == 0xffffffff80000000
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    // --- SRAIW
    liu(t0, 0x80000000)

    sraiw t1, t0, 31
    //prgchk reg t1 == 0xffffffffffffffff

    sraiw t1, t0, 0
    //prgchk reg t1 == 0xffffffff80000000

    sraiw t1, t0, 1
    //prgchk reg t1 == 0xffffffffc0000000

    sraiw t1, t0, 4
    //prgchk reg t1 == 0xfffffffff8000000

    liu(t0, 0x70000000)
    
    sraiw t1, t0, 1
    //prgchk reg t1 == 0x0000000038000000

    sraiw t1, t0, 4
    //prgchk reg t1 == 0x0000000007000000

    sraiw t1, t0, 31
    //prgchk reg t1 == 0x0000000000000000

    sraiw t1, t0, 0
    //prgchk reg t1 == 0x00000000070000000
j exit