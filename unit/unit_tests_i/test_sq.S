#include "insns.S" 
#include "utils.S"

.section .data
    store_1: .dword 0x1234567890abcdef
             .dword 0xfedcba0987654321

    varl:     .dword 0x8081828384858687
    varh:     .dword 0x8889909192939495
    .align 16
    .byte 0x42
    unal1l:   .dword 0x1234567890abcdef
    unal1h:   .dword 0xfedcba0987654321
    .byte 0x42
    unal2l:   .dword 0xb87b4ef805445bd8
    unal2h:   .dword 0x85893964acd3187b
    .byte 0x42
    unal3l:   .dword 0xfb681a7a7991ed4b
    unal3h:   .dword 0xed1449095e68802b
    .byte 0x42
    unal4l:   .dword 0xbf3b753b9bc1b087
    unal4h:   .dword 0x82c7102ce59064a0
    .byte 0x42
    unal5l:   .dword 0xa403b381b128c2b3
    unal5h:   .dword 0x8c65cd39a2fadb80
    .byte 0x42
    unal6l:   .dword 0x9eed51f380209332
    unal6h:   .dword 0xed4ef41ee9676459
    .byte 0x42
    unal7l:   .dword 0xcd99a395627b2a5c
    unal7h:   .dword 0xd9ba3064090bd49a
    .byte 0x42
    unal8l:   .dword 0x943713ddbde447a9
    unal8h:   .dword 0xa9d02dd8567af991
    .byte 0x42
    unal9l:   .dword 0xec092b948ec961b8
    unal9h:   .dword 0xff9606b2fed8d515
    .byte 0x42
    unal10l:   .dword 0xd740573fb7e1e78e
    unal10h:   .dword 0x9e23a50e544cf3a3
    .byte 0x42
    unal11l:   .dword 0x8e2beca94fc38bf4
    unal11h:   .dword 0xcee8d6a79d2d550c
    .byte 0x42
    unal12l:   .dword 0xbd6da1af1cc8e0f2
    unal12h:   .dword 0xcf30edf1363051e8
    .byte 0x42
    unal13l:   .dword 0xd114550db626af84
    unal13h:   .dword 0x9c127e07dd9738f0
    .byte 0x42
    unal14l:   .dword 0xbb6c0f1c3c13290c
    unal14h:   .dword 0xac6c8ab0ec00fcb2
    .byte 0x42
    unal15l:   .dword 0x8a9781c17cd71a25
    unal15h:   .dword 0xe54aa5f95d5a6109
    .align 16
    tab_tst:   .octa  0xd6d1a16d4edfb494bc85ea8b82ebc510, 0xa4b42a831f580406f8a855da1252ae72, 0xd1fc03576392796f8a3f6cc1ff34af51, 0xf7ddab0825ee983ef386f797302b1329, 0x862f0605e5e10bea145249745beb7b9c, 0x97c97d2f55170d7238d3d5013c60d66c, 0x960eca8c43b42c292b2c8cb6022e8db2, 0x9277b9663276a56cf052f9992b9abe1b
    bigtab_start: .octa 0xdb00f9f4dd90c17a6739087c1eeba4cd
                  .fill 2032, 1, 0x42
    bigtab_mid:   .octa 0x89f4edddd3c94ccfa37aa040e7c4aacc
                  .fill 2031, 1, 0x88
    bigtab_end:   .octa 0xa471884c8f32f364fcfa75ba8a71928b

              
.section .text.init,"ax",@progbits
.global _start
_start:
    // Test store and load in succession.
    la t0, store_1
    liu t1, 0xdeadbeefcafebabe0000000000000000
    liu t2, 0xfeedbeefbeeffeed
    or t1, t1, t2
    sq t1, 0, t0
    lq t2, 0(t0)
    //prgchk reg t2 == 0xdeadbeefcafebabefeedbeefbeeffeed


    // Check standalone store.
    la t0, varl
    liu t1, 0xabcd12346321dcba0000000000000000
    liu t2, 0x7412589633698521
    or t1, t1, t2
    sq t1, 0, t0
    //prgchk var varl == 0x7412589633698521
    //prgchk var varh == 0xabcd12346321dcba

    // Check unaligned stores
    la t0, unal1l
    sq t1, 0, t0
    //prgchk var unal1l == 0x7412589633698521
    //prgchk var unal1h == 0xabcd12346321dcba
    
    la t0, unal2l
    sq t1, 0, t0
    //prgchk var unal2l == 0x7412589633698521
    //prgchk var unal2h == 0xabcd12346321dcba

    la t0, unal3l
    sq t1, 0, t0
    //prgchk var unal3l == 0x7412589633698521
    //prgchk var unal3h == 0xabcd12346321dcba

    la t0, unal4l
    sq t1, 0, t0
    //prgchk var unal4l == 0x7412589633698521
    //prgchk var unal4h == 0xabcd12346321dcba

    la t0, unal5l
    sq t1, 0, t0
    //prgchk var unal5l == 0x7412589633698521
    //prgchk var unal5h == 0xabcd12346321dcba

    la t0, unal6l
    sq t1, 0, t0
    //prgchk var unal6l == 0x7412589633698521
    //prgchk var unal6h == 0xabcd12346321dcba

    la t0, unal7l
    sq t1, 0, t0
    //prgchk var unal7l == 0x7412589633698521
    //prgchk var unal7h == 0xabcd12346321dcba

    la t0, unal8l
    sq t1, 0, t0
    //prgchk var unal8l == 0x7412589633698521
    //prgchk var unal8h == 0xabcd12346321dcba

    la t0, unal9l
    sq t1, 0, t0
    //prgchk var unal9l == 0x7412589633698521
    //prgchk var unal9h == 0xabcd12346321dcba

    la t0, unal10l
    sq t1, 0, t0
    //prgchk var unal10l == 0x7412589633698521
    //prgchk var unal10h == 0xabcd12346321dcba

    la t0, unal11l
    sq t1, 0, t0
    //prgchk var unal11l == 0x7412589633698521
    //prgchk var unal11h == 0xabcd12346321dcba

    la t0, unal12l
    sq t1, 0, t0
    //prgchk var unal12l == 0x7412589633698521
    //prgchk var unal12h == 0xabcd12346321dcba

    la t0, unal13l
    sq t1, 0, t0
    //prgchk var unal13l == 0x7412589633698521
    //prgchk var unal13h == 0xabcd12346321dcba

    la t0, unal14l
    sq t1, 0, t0
    //prgchk var unal14l == 0x7412589633698521
    //prgchk var unal14h == 0xabcd12346321dcba

    la t0, unal15l
    sq t1, 0, t0
    //prgchk var unal15l == 0x7412589633698521
    //prgchk var unal15h == 0xabcd12346321dcba

    // Check array storage (immediate offsets)
    la t0, tab_tst
    li t1, 0xdeadbeefcafebabe
    slli(t1, t1, 64)
    li t2, 0x1234567890abcdef
    or t1, t1, t2

    sq t1, 0, t0
    //prgchk gdb ((unsigned long*) &tab_tst)[0] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &tab_tst)[1] == 0xdeadbeefcafebabe

    sq t1, 16, t0
    //prgchk gdb ((unsigned long*) &tab_tst)[2] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &tab_tst)[3] == 0xdeadbeefcafebabe

    sq t1, 32, t0
    //prgchk gdb ((unsigned long*) &tab_tst)[4] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &tab_tst)[5] == 0xdeadbeefcafebabe

    sq t1, 48, t0
    //prgchk gdb ((unsigned long*) &tab_tst)[6] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &tab_tst)[7] == 0xdeadbeefcafebabe

    sq t1, 64, t0
    //prgchk gdb ((unsigned long*) &tab_tst)[8] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &tab_tst)[9] == 0xdeadbeefcafebabe

    sq t1, 80, t0
    //prgchk gdb ((unsigned long*) &tab_tst)[10] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &tab_tst)[11] == 0xdeadbeefcafebabe

    sq t1, 96, t0
    //prgchk gdb ((unsigned long*) &tab_tst)[12] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &tab_tst)[13] == 0xdeadbeefcafebabe

    sq t1, 112, t0
    //prgchk gdb ((unsigned long*) &tab_tst)[14] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &tab_tst)[15] == 0xdeadbeefcafebabe

    // Load with minimum and maximal immediate offsets.
    la t0, bigtab_mid
    //prgchk gdb ((unsigned long*) &bigtab_start)[0] != 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &bigtab_start)[1] != 0xdeadbeefcafebabe
    sq t1, -2048, t0
    //prgchk gdb ((unsigned long*) &bigtab_start)[0] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &bigtab_start)[1] == 0xdeadbeefcafebabe

    sq t1, 2047, t0
    //prgchk gdb ((unsigned long*) &bigtab_end)[0] == 0x1234567890abcdef
    //prgchk gdb ((unsigned long*) &bigtab_end)[1] == 0xdeadbeefcafebabe
    j exit
