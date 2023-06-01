	.file	"ns16550a.c"
	.option nopic
	.attribute arch, "rv128i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.type	ns16550a_getchar, @function
ns16550a_getchar:
	lui	a5,%hi(.LANCHOR0)
	lq	a4,%lo(.LANCHOR0)(a5)
	lbu	a5,5(a4)
	andi	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L3
	lbu	a0,0(a4)
	andi	a0,a0,0xff
	sext.w	a0,a0
	ret
.L3:
	li	a0,-1
	ret
	.size	ns16550a_getchar, .-ns16550a_getchar
	.align	1
	.type	ns16550a_putchar, @function
ns16550a_putchar:
	lui	a5,%hi(.LANCHOR0)
	lq	a4,%lo(.LANCHOR0)(a5)
.L6:
	lbu	a5,5(a4)
	andi	a5,a5,64
	andi	a5,a5,0xff
	beq	a5,zero,.L6
	andi	a5,a0,0xff
	andi	a0,a0,255
	sb	a5,0(a4)
	sext.w	a0,a0
	ret
	.size	ns16550a_putchar, .-ns16550a_putchar
	.align	1
	.type	ns16550a_init, @function
ns16550a_init:
	addi	sp,sp,-48
	li	a0,196608
	sq	ra,32(sp)
	sq	s0,16(sp)
	sq	s1,0(sp)
	call	getauxval
	slli	a5,a0,64
	lui	s1,%hi(.LANCHOR0)
	srli	a5,a5,64
	addi	s1,s1,%lo(.LANCHOR0)
	li	a0,69632
	sq	a5,0(s1)
	call	getauxval
	mv	s0,a0
	li	a0,69632
	addi	a0,a0,256
	call	getauxval
	sext.d	s0,s0
	slliw	a0,a0,4
	divuw	a0,s0,a0
	lq	a5,0(s1)
	li	a4,-128
	sb	a4,3(a5)
	andi	a4,a0,0xff
	srliw	a0,a0,8
	sb	a4,0(a5)
	andi	a0,a0,0xff
	sb	a0,1(a5)
	li	a4,11
	sb	a4,3(a5)
	lq	ra,32(sp)
	lq	s0,16(sp)
	lq	s1,0(sp)
	addi	sp,sp,48
	jr	ra
	.size	ns16550a_init, .-ns16550a_init
	.globl	console_ns16550a
	.data
	.align	4
	.type	console_ns16550a, @object
	.size	console_ns16550a, 48
console_ns16550a:
	.octa	ns16550a_init
	.octa	ns16550a_getchar
	.octa	ns16550a_putchar
	.bss
	.align	4
	.set	.LANCHOR0,. + 0
	.type	uart, @object
	.size	uart, 16
uart:
	.zero	16
	.ident	"GCC: (g5eccf3e74fc) 12.1.0"
