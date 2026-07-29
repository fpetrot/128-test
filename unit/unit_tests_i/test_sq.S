#include "exit.S"

.section .data
    store: .octa 0x1234567890abcdef
    tab_tst: .octa  0xd6d1a16d4edfb494bc85ea8b82ebc510, 0xa4b42a831f580406f8a855da1252ae72, 0xd1fc03576392796f8a3f6cc1ff34af51, 0xf7ddab0825ee983ef386f797302b1329, 0x862f0605e5e10bea145249745beb7b9c, 0x97c97d2f55170d7238d3d5013c60d66c, 0x960eca8c43b42c292b2c8cb6022e8db2, 0x9277b9663276a56cf052f9992b9abe1b
    bigtab_start: .octa 0xdb00f9f4dd90c17a6739087c1eeba4cd
                  .fill 2032, 1, 0x42
    bigtab_mid:   .octa 0x89f4edddd3c94ccfa37aa040e7c4aacc
                  .fill 2016, 1, 0x88
    bigtab_end:   .octa 0xa471884c8f32f364fcfa75ba8a71928b

              
.section .text.init,"ax",@progbits
.global _start
_start:
    // Test store and load in succession
    la s0, store
    li s1, 0xdeadbeefcafebabefeedbeefbeeffeed
    sq s1, 0(s0)
    lq s2, 0(s0)
    //prgchk reg s2 == 0xdeadbeefcafebabefeedbeefbeeffeed

    // Check standalone stores
    la s0, store
    li s1, 0xabcd12346321dcba7412589633698521    
    sq s1, 0(s0)
    //prgchk gdb (unsigned long long *)store == 0xabcd12346321dcba7412589633698521

    // Check array storage (immediate offsets)
    la s0, tab_tst
    li s1, 0x11111111111111111111111111111111
    sq s1, 0 * 16(s0)
    //prgchk gdb ((unsigned long long*) &tab_tst)[0] == 0x11111111111111111111111111111111
    li s1, 0x22222222222222222222222222222222
    sq s1, 1 * 16(s0)
    //prgchk gdb ((unsigned long long*) &tab_tst)[1] == 0x22222222222222222222222222222222
    li s1, 0x33333333333333333333333333333333
    sq s1, 2 * 16(s0)
    //prgchk gdb ((unsigned long long*) &tab_tst)[2] == 0x33333333333333333333333333333333
    li s1, 0x44444444444444444444444444444444
    sq s1, 3 * 16(s0)
    //prgchk gdb ((unsigned long long*) &tab_tst)[3] == 0x44444444444444444444444444444444
    li s1, 0x55555555555555555555555555555555
    sq s1, 4 * 16(s0)
    //prgchk gdb ((unsigned long long*) &tab_tst)[4] == 0x55555555555555555555555555555555
    li s1, 0x66666666666666666666666666666666
    sq s1, 5 * 16(s0)
    //prgchk gdb ((unsigned long long*) &tab_tst)[5] == 0x66666666666666666666666666666666
    li s1, 0x77777777777777777777777777777777
    sq s1, 6 * 16(s0)
    //prgchk gdb ((unsigned long long*) &tab_tst)[6] == 0x77777777777777777777777777777777
    li s1, 0x88888888888888888888888888888888
    sq s1, 7 * 16(s0)
    //prgchk gdb ((unsigned long long*) &tab_tst)[7] == 0x88888888888888888888888888888888

    // Load with minimum and maximal immediate offsets.
    la s0, bigtab_mid
    //prgchk gdb ((unsigned long long *) &bigtab_start)[0] != 0xdeadbeefcafebabe1234567890abcdef
    li s1,  0xdeadbeefcafebabe1234567890abcdef
    sq s1, -2048(s0)
    //prgchk gdb ((unsigned long long *) &bigtab_start)[0] == 0xdeadbeefcafebabe1234567890abcdef

    sq s1, 2032(s0)
    //prgchk gdb ((unsigned long long *) &bigtab_end)[0] == 0xdeadbeefcafebabe1234567890abcdef
    j exit
