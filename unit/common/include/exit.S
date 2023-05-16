#pragma once
.section .data
    putint_buf: .fill 4096, 1, 0
.section .text

.global exit
exit:
    li  t0, 0x100000
    li  t1, 0xde003333
    sw  t1, 0(t0)
    wfi
j       exit
