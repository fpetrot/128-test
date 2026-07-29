#include "exit.S"

.section .data
    tst1:     .octa 0xae36d53f51a671836aba36a5d5d76824
    tst1_mlziefj:     .octa 0xae36d53f51a671836aba36a5d5d76824
    tst2:     .octa 0
    tst3:     .octa 0xffffffffffffffffffffffffffffffff
    .align 16
    tab_tst:   .octa 1, 2, 3, 5, 7, 11, 0, 0xffffffffffffffffffffffffffffffff, 0xd4faa2a0516c5c5539f7a734a652847a
    bigtab_start: .octa 0xdb00f9f4dd90c17a6739087c1eeba4cd
                  .fill 2032, 1, 0x42
    bigtab_mid:   .octa 0x89f4edddd3c94ccfa37aa040e7c4aacc
                  .fill 2016, 1, 0x88
    bigtab_end:   .octa 0xa471884c8f32f364fcfa75ba8a71928b

.section .text.init,"ax",@progbits
.global _start
_start:

    // Test load with small shifts (from array)


    // Basic loads
    la s0, tst1
    lq s1, 16(s0)
    //prgchk reg s1 == 0xae36d53f51a671836aba36a5d5d76824

    la s0, tst2
    lq s0, 0(s0)
    //prgchk reg s0 == 0

    la s0, tst3
    lq s0, 0(s0)
    //prgchk reg s0 == 0xffffffffffffffffffffffffffffffff

    // Test load with small shifts (from array)
    la s0, tab_tst
    lq s1, 0(s0)
    //prgchk reg s1 == 1

    la s0, tab_tst
    lq s1, 16(s0)
    //prgchk reg s1 == 2

    lq s1, 32(s0)
    //prgchk reg s1 == 3

    lq s1, 48(s0)
    //prgchk reg s1 == 5

    lq s1, 64(s0)
    //prgchk reg s1 == 7

    lq s1, 80(s0)
    //prgchk reg s1 == 11

    lq s1, 96(s0)
    //prgchk reg s1 == 0

    lq s1, 112(s0)
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    lq s1, 128(s0)
    //prgchk reg s1 == 0xd4faa2a0516c5c5539f7a734a652847a

    // Load with max and min immediate offsets.
    la s0, bigtab_mid
    lq s1, -2048(s0)
    //prgchk reg s1 == 0xdb00f9f4dd90c17a6739087c1eeba4cd

    lq s1, 2032(s0)
    //prgchk reg s1 == 0xa471884c8f32f364fcfa75ba8a71928b

    j exit
