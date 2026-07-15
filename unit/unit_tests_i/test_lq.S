#include "exit.S"

.section .data
    tst1:     .octa 0xae36d53f51a671836aba36a5d5d76824
    tst1_mlziefj:     .octa 0xae36d53f51a671836aba36a5d5d76824
    tst2:     .octa 0
    tst3:     .octa 0xffffffffffffffffffffffffffffffff
    .align 16
    .byte 0x42
    unal1:    .octa 0xa79b71e63793aaa39dbab87660386b3b
    .byte 0x42
    unal2:    .octa 0xbf859750de311d51fcf2cdbdecfe2c00
    .byte 0x42
    unal3:    .octa 0xb75e5d09084915ae23142b35a23a3991
    .byte 0x42
    unal4:    .octa 0x9ab89e16aaf84537677e7b46104f34e5
    .byte 0x42
    unal5:    .octa 0xf5f7db207647c4329415954eeabaade4
    .byte 0x42
    unal6:    .octa 0xb378a417ad18889a8b9280922bee38dd
    .byte 0x42
    unal7:    .octa 0x861b306dc5a7896e2f484a63dccdd43b
    .byte 0x42
    unal8:    .octa 0xbbce145f83c052c636e924632990ae69
    .byte 0x42
    unal9:    .octa 0xb9f58a1eac7b85a9b386efacb1c37b06
    .byte 0x42
    unal10:    .octa 0x97ea66b79fb21fecab0c088aa3f58d7d
    .byte 0x42
    unal11:    .octa 0xf0ad7bdaa44f176545b6d3ff2926feb7
    .byte 0x42
    unal12:    .octa 0xb1d62fa49375392ae28d639222cbff8c
    .byte 0x42
    unal13:    .octa 0xbd9a1853b5071914e3a32b0bec465064
    .byte 0x42
    unal14:    .octa 0xf0524d131c4013745b6521a4b9e32873
    .byte 0x42
    unal15:    .octa 0xb80295bf66233ed6f231249451f0c6e0
    .align 16
    tab_tst:   .octa 1, 2, 3, 5, 7, 11, 0, 0xffffffffffffffffffffffffffffffff, 0xd4faa2a0516c5c5539f7a734a652847a
    bigtab_start: .octa 0xdb00f9f4dd90c17a6739087c1eeba4cd
                  .fill 2032, 1, 0x42
    bigtab_mid:   .octa 0x89f4edddd3c94ccfa37aa040e7c4aacc
                  .fill 2031, 1, 0x88
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

    // Read unaligned values (all offsets from 0 to 16)
    la s0, unal1
    lq s1, 0(s0)
    //prgchk reg s1 == 0xa79b71e63793aaa39dbab87660386b3b

    la s0, unal2
    lq s1, 0(s0)
    //prgchk reg s1 == 0xbf859750de311d51fcf2cdbdecfe2c00

    la s0, unal3
    lq s1, 0(s0)
    //prgchk reg s1 == 0xb75e5d09084915ae23142b35a23a3991
    
    la s0, unal4
    lq s1, 0(s0)
    //prgchk reg s1 == 0x9ab89e16aaf84537677e7b46104f34e5

    la s0, unal5
    lq s1, 0(s0)
    //prgchk reg s1 == 0xf5f7db207647c4329415954eeabaade4

    la s0, unal6
    lq s1, 0(s0)
    //prgchk reg s1 == 0xb378a417ad18889a8b9280922bee38dd

    la s0, unal7
    lq s1, 0(s0)
    //prgchk reg s1 == 0x861b306dc5a7896e2f484a63dccdd43b

    la s0, unal8
    lq s1, 0(s0)
    //prgchk reg s1 == 0xbbce145f83c052c636e924632990ae69

    la s0, unal9
    lq s1, 0(s0)
    //prgchk reg s1 == 0xb9f58a1eac7b85a9b386efacb1c37b06

    la s0, unal10
    lq s1, 0(s0)
    //prgchk reg s1 == 0x97ea66b79fb21fecab0c088aa3f58d7d

    la s0, unal11
    lq s1, 0(s0)
    //prgchk reg s1 == 0xf0ad7bdaa44f176545b6d3ff2926feb7

    la s0, unal12
    lq s1, 0(s0)
    //prgchk reg s1 == 0xb1d62fa49375392ae28d639222cbff8c

    la s0, unal13
    lq s1, 0(s0)
    //prgchk reg s1 == 0xbd9a1853b5071914e3a32b0bec465064

    la s0, unal14
    lq s1, 0(s0)
    //prgchk reg s1 == 0xf0524d131c4013745b6521a4b9e32873

    la s0, unal15
    lq s1, 0(s0)
    //prgchk reg s1 == 0xb80295bf66233ed6f231249451f0c6e0

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

    lq s1, 2047(s0)
    //prgchk reg s1 == 0xa471884c8f32f364fcfa75ba8a71928b

    j exit
