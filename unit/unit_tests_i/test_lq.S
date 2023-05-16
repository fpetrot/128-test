#include "exit.S"

.section .data
    tst1:     .octa 0xae36d53f51a671836aba36a5d5d76824
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
    // Basic loads
    la t0, tst1
    lq t0, 0(t0)
    //prgchk reg t0 == 0xae36d53f51a671836aba36a5d5d76824

    la t0, tst2
    lq t0, 0(t0)
    //prgchk reg t0 == 0

    la t0, tst3
    lq t0, 0(t0)
    //prgchk reg t0 == 0xffffffffffffffffffffffffffffffff

    // Read unaligned values (all offsets from 0 to 16)
    la t0, unal1
    lq t1, 0(t0)
    //prgchk reg t1 == 0xa79b71e63793aaa39dbab87660386b3b

    la t0, unal2
    lq t1, 0(t0)
    //prgchk reg t1 == 0xbf859750de311d51fcf2cdbdecfe2c00

    la t0, unal3
    lq t1, 0(t0)
    //prgchk reg t1 == 0xb75e5d09084915ae23142b35a23a3991
    
    la t0, unal4
    lq t1, 0(t0)
    //prgchk reg t1 == 0x9ab89e16aaf84537677e7b46104f34e5

    la t0, unal5
    lq t1, 0(t0)
    //prgchk reg t1 == 0xf5f7db207647c4329415954eeabaade4

    la t0, unal6
    lq t1, 0(t0)
    //prgchk reg t1 == 0xb378a417ad18889a8b9280922bee38dd

    la t0, unal7
    lq t1, 0(t0)
    //prgchk reg t1 == 0x861b306dc5a7896e2f484a63dccdd43b

    la t0, unal8
    lq t1, 0(t0)
    //prgchk reg t1 == 0xbbce145f83c052c636e924632990ae69

    la t0, unal9
    lq t1, 0(t0)
    //prgchk reg t1 == 0xb9f58a1eac7b85a9b386efacb1c37b06

    la t0, unal10
    lq t1, 0(t0)
    //prgchk reg t1 == 0x97ea66b79fb21fecab0c088aa3f58d7d

    la t0, unal11
    lq t1, 0(t0)
    //prgchk reg t1 == 0xf0ad7bdaa44f176545b6d3ff2926feb7

    la t0, unal12
    lq t1, 0(t0)
    //prgchk reg t1 == 0xb1d62fa49375392ae28d639222cbff8c

    la t0, unal13
    lq t1, 0(t0)
    //prgchk reg t1 == 0xbd9a1853b5071914e3a32b0bec465064

    la t0, unal14
    lq t1, 0(t0)
    //prgchk reg t1 == 0xf0524d131c4013745b6521a4b9e32873

    la t0, unal15
    lq t1, 0(t0)
    //prgchk reg t1 == 0xb80295bf66233ed6f231249451f0c6e0

    // Test load with small shifts (from array)
    la t0, tab_tst
    lq t1, 0(t0)
    //prgchk reg t1 == 1

    la t0, tab_tst
    lq t1, 16(t0)
    //prgchk reg t1 == 2

    lq t1, 32(t0)
    //prgchk reg t1 == 3

    lq t1, 48(t0)
    //prgchk reg t1 == 5

    lq t1, 64(t0)
    //prgchk reg t1 == 7

    lq t1, 80(t0)
    //prgchk reg t1 == 11

    lq t1, 96(t0)
    //prgchk reg t1 == 0

    lq t1, 112(t0)
    //prgchk reg t1 == 0xffffffffffffffffffffffffffffffff

    lq t1, 128(t0)
    //prgchk reg t1 == 0xd4faa2a0516c5c5539f7a734a652847a

    // Load with max and min immediate offsets.
    la t0, bigtab_mid
    lq t1, -2048(t0)
    //prgchk reg t1 == 0xdb00f9f4dd90c17a6739087c1eeba4cd

    lq t1, 2047(t0)
    //prgchk reg t1 == 0xa471884c8f32f364fcfa75ba8a71928b

    j exit
