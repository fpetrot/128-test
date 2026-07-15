#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0x75033785b9ca9eec0ec94d28201e1869
    //prgchk reg s0 == 0x75033785b9ca9eec0ec94d28201e1869

    // and with zero : movi 0
    li s1, 0
    and s1, s0, s1
    //prgchk reg s1 == 0x00000000000000000000000000000000

    // and with -1 : no-op
    li s1, -1
    and s1, s0, s1
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1869

    // various masks
    li s1, 0x55555555555555555555555555555555
    //prgchk reg s1 == 0x55555555555555555555555555555555
    and s2, s0, s1
    //prgchk reg s2 == 0x55011505114014440441450000141041

    li s1, 0x12341234abcdabcd567856781234efef
    //prgchk reg s1 == 0x12341234abcdabcd567856781234efef
    and s2, s0, s1
    //prgchk reg s2 == 0x10001204a9c88acc0648442800140869

    li s1, 0xff
    //prgchk reg s1 == 0xff
    and s2, s0, s1
    //prgchk reg s2 == 0x00000000000000000000000000000069

    li s1, 0xffff
    //prgchk reg s1 == 0xffff
    and s2, s0, s1
    //prgchk reg s2 == 0x00000000000000000000000000001869

    li s1, 0xffffffff
    //prgchk reg s1 == 0xffffffff
    and s2, s0, s1
    //prgchk reg s2 == 0x000000000000000000000000201e1869

    li s1, 0xffffffffffffffff
    //prgchk reg s1 == 0xffffffffffffffff
    and s2, s0, s1
    //prgchk reg s2 == 0x00000000000000000ec94d28201e1869

    li s1, 0x80000000000000000000000000000000
    //prgchk reg s1 == 0x80000000000000000000000000000000
    and s2, s0, s1
    //prgchk reg s2 == 0x00000000000000000000000000000000

    li s0, 0xd15d6ce86bb031505946fbf11b39add6
    //prgchk reg s0 == 0xd15d6ce86bb031505946fbf11b39add6

    li s1, 0x80000000000000000000000000000000
    //prgchk reg s1 == 0x80000000000000000000000000000000
    and s2, s0, s1
    //prgchk reg s2 == 0x80000000000000000000000000000000
    j exit
