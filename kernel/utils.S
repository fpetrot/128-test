#include "insns.S"
#include "multisize_helper.S"
#include "utils_defs.S"

.section .bss
    buf_putint: .fill 1024, 1, 0

.section .text

.global exit
exit:
    li  t0, 0x100000
    li  t1, 0xde003333
    sw  t1, 0(t0)
    wfi
j       exit

.global puts
puts:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)
    addi sp, sp, -TYPE_OFF
    store(s0, 0, sp)

    mv s0, a0

    j .Lputstr_cndchk
.Lputstr_body:
    lb a0, 0(s0)
    jal putchar

    addi s0, s0, 1
.Lputstr_cndchk:
    lbu t0, 0(s0)
    bnez t0, .Lputstr_body

    load(s0, 0, sp)
    addi sp, sp, TYPE_OFF
    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

// void putint(uint v)
.global putint
putint:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)

    la t0, buf_putint
    addi t0, t0, 256

.Lpi_dw_bdy:
    li t1, 10
    remu t2, a0, t1

    // Compute ASCII digit and store it to buf.
    addi t2, t2, '0'
    andi t2, t2, 0xff
    addi t0, t0, -1
    sb t2, 0(t0)

    divu a0, a0, t1

.Lpi_dw_cnd:
    bnez a0, .Lpi_dw_bdy

    mv a0, t0
    jal puts

    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

// void putint_bin(val, bits)
.global putint_bin
putint_bin:
    addi sp, sp, -TYPE_OFF * 4
    store(ra, 0 * TYPE_OFF, sp)
    store(s0, 1 * TYPE_OFF, sp)
    store(s1, 2 * TYPE_OFF, sp)
    store(s2, 3 * TYPE_OFF, sp)

    mv s0, a0
    mv s1, a1
    la s2, buf_putint
    addi s2, s2, 200

    sb zero, 0(s2)

    j .Lpi_bin_forchk
.Lpi_bin_forbdy:
    andi t0, s0, 1
    addi t0, t0, '0'
    addi s2, s2, -1
    sb t0, 0(s2)

    addi s1, s1, -1
    srli s0, s0, 1

.Lpi_bin_forchk:
    bnez s1, .Lpi_bin_forbdy

    mv a0, s2
    jal puts
    
    load(ra, 0 * TYPE_OFF, sp)
    load(s0, 1 * TYPE_OFF, sp)
    load(s1, 2 * TYPE_OFF, sp)
    load(s2, 3 * TYPE_OFF, sp)
    addi sp, sp, TYPE_OFF * 4
    
    ret

// void putint_hex(val, bits)
.global putint_hex
putint_hex:
    addi sp, sp, -TYPE_OFF * 4
    store(ra, 0 * TYPE_OFF, sp)
    store(s0, 1 * TYPE_OFF, sp)
    store(s1, 2 * TYPE_OFF, sp)
    store(s2, 3 * TYPE_OFF, sp)

    mv s0, a0
    mv s1, a1

    la s2, buf_putint
    addi s2, s2, 250
    sb zero, 0(s2)

    j .Lpi_hex_forchk
.Lpi_hex_forbdy:
    andi t0, s0, 0xf
    li t1, 9
    bgtu t0, t1, .Lpi_hex_letterdigit

    // digit <= 9 
    addi t0, t0, '0'
    j .Lpi_hex_append_digit
.Lpi_hex_letterdigit:
    // digit >= a 
    addi t0, t0, -10
    addi t0, t0, 'a'
.Lpi_hex_append_digit:
    addi s2, s2, -1
    sb t0, 0(s2)

    addi s1, s1, -4
    srli s0, s0, 4

.Lpi_hex_forchk:
    bge s1, zero, .Lpi_hex_forbdy

    mv a0, s2
    jal puts

    load(ra, 0 * TYPE_OFF, sp)
    load(s0, 1 * TYPE_OFF, sp)
    load(s1, 2 * TYPE_OFF, sp)
    load(s2, 3 * TYPE_OFF, sp)
    addi sp, sp, TYPE_OFF * 4
    
    ret

.global put_newline
put_newline:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)

    li a0, '\n'
    jal putchar

    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

// void* memset(void* dest, value, num)
.global memset
memset:
    li t0, 0
    mv t1, a0
    j .Lmemset_forchk
.Lmemset_forbdy:
    sb a1, 0(t1)

    addi t0, t0, 1
    addi t1, t1, 1
.Lmemset_forchk:
    bltu t0, a2, .Lmemset_forbdy

    ret