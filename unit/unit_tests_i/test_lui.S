#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:    
    // Check sign extension to 128-bits.
    lui t0, 0x80000
    //prgchk reg t0 == 0xffffffffffffffffffffffff80000000


    lui t0, 0x70000
    //prgchk reg t0 == 0x00000000000000000000000070000000


    // Load max value 0xfffff
    lui t3, 0xfffff
    //prgchk reg t3 == 0xfffffffffffffffffffffffffffff000

    // Load garbage and then lui 0, check if zeroed correctly.
    liu t0, 0xffffffffffffffff
    liu t1, 0xffffffffffffffff
    or t0, t0, t1

    lui t0, 0
    //prgchk reg t0 == 0

    // Load a few random values
    lui t1, 0x12345
    //prgchk reg t1 == 0x00000000000000000000000012345000


    lui t2, 1
    //prgchk reg t2 == 0x00000000000000000000000000001000
 

    // Check no-op on zero
    lui zero, 0xfffff
    //prgchk reg zero == 0
    j exit
