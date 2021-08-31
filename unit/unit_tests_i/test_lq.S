#include "insns.S" 
#include "utils.S"

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
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    // Basic loads
    la t0, tst1
    lq(t0, 0, t0)
    //prgchk reg t0 == 0x6aba36a5d5d76824
    srli(t1, t0, 64)
    //prgchk reg t1 == 0xae36d53f51a67183

    la t0, tst2
    lq(t0, 0, t0)
    //prgchk reg t0 == 0
    srli(t1, t0, 64)
    //prgchk reg t1 == 0

    la t0, tst3
    lq(t0, 0, t0)
    //prgchk reg t0 == 0xffffffffffffffff
    srli(t1, t0, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    // Read unaligned values (all offsets from 0 to 16)
    la t0, unal1
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x9dbab87660386b3b
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xa79b71e63793aaa3

    la t0, unal2
    lq(t1, 0, t0)
    //prgchk reg t1 == 0xfcf2cdbdecfe2c00
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xbf859750de311d51

    la t0, unal3
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x23142b35a23a3991
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xb75e5d09084915ae
    
    la t0, unal4
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x677e7b46104f34e5
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x9ab89e16aaf84537

    la t0, unal5
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x9415954eeabaade4
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xf5f7db207647c432

    la t0, unal6
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x8b9280922bee38dd
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xb378a417ad18889a

    la t0, unal7
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x2f484a63dccdd43b
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x861b306dc5a7896e

    la t0, unal8
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x36e924632990ae69
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xbbce145f83c052c6

    la t0, unal9
    lq(t1, 0, t0)
    //prgchk reg t1 == 0xb386efacb1c37b06
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xb9f58a1eac7b85a9

    la t0, unal10
    lq(t1, 0, t0)
    //prgchk reg t1 == 0xab0c088aa3f58d7d
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x97ea66b79fb21fec

    la t0, unal11
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x45b6d3ff2926feb7
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xf0ad7bdaa44f1765

    la t0, unal12
    lq(t1, 0, t0)
    //prgchk reg t1 == 0xe28d639222cbff8c
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xb1d62fa49375392a

    la t0, unal13
    lq(t1, 0, t0)
    //prgchk reg t1 == 0xe3a32b0bec465064
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xbd9a1853b5071914

    la t0, unal14
    lq(t1, 0, t0)
    //prgchk reg t1 == 0x5b6521a4b9e32873
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xf0524d131c401374

    la t0, unal15
    lq(t1, 0, t0)
    //prgchk reg t1 == 0xf231249451f0c6e0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xb80295bf66233ed6

    // Test load with small shifts (from array)
    la t0, tab_tst
    lq(t1, 0, t0)
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    la t0, tab_tst
    lq(t1, 16, t0)
    //prgchk reg t1 == 2
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    lq(t1, 32, t0)
    //prgchk reg t1 == 3
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    lq(t1, 48, t0)
    //prgchk reg t1 == 5
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    lq(t1, 64, t0)
    //prgchk reg t1 == 7
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    lq(t1, 80, t0)
    //prgchk reg t1 == 11
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    lq(t1, 96, t0)
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    lq(t1, 112, t0)
    //prgchk reg t1 == 0xffffffffffffffff
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    lq(t1, 128, t0)
    //prgchk reg t1 == 0x39f7a734a652847a
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xd4faa2a0516c5c55

    // Load with max and min immediate offsets.
    la t0, bigtab_mid
    lq(t1, -2048, t0)
    //prgchk reg t1 == 0x6739087c1eeba4cd
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xdb00f9f4dd90c17a

    lq(t1, 2047, t0)
    //prgchk reg t1 == 0xfcfa75ba8a71928b
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xa471884c8f32f364
j exit