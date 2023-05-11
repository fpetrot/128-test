#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // --- SLLIW
    liu(t0, 0xffffffff)
    
    // Check sign extend to 128 bits
    slliw t0, t0, 31
    //prgchk reg t0 == 0xffffffffffffffffffffffff80000000

    slliw t0, t0, 1
    //prgchk reg t0 == 0

    // --- SRLIW
    liu(t0, 0xfffffff)
    
    srliw t1, t0, 4
    //prgchk reg t1 == 0x000000000fffffff

    liu(t0, 0x80000000)
    //prgchk reg t0 == 0x80000000
    srliw t1, t0, 0
    //prgchk reg t1 == 0xffffffffffffffffffffffff80000000

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

    liu(t0, 0x70000000
    
    sraiw t1, t0, 1
    //prgchk reg t1 == 0x0000000038000000

    sraiw t1, t0, 4
    //prgchk reg t1 == 0x0000000007000000

    sraiw t1, t0, 31
    //prgchk reg t1 == 0x0000000000000000

    sraiw t1, t0, 0
    //prgchk reg t1 == 0x00000000070000000
    j exit
