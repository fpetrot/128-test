	.file	"memset.c"
	.option nopic
	.attribute arch, "rv128i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	memset
	.type	memset, @function
memset:
	addi	sp,sp,-80
	sq	s0,64(sp)
	addi	s0,sp,80
	sq	a0,-48(s0)
	mv	a5,a1
	sq	a2,-80(s0)
	sw	a5,-52(s0)
	lq	a5,-48(s0)
	sq	a5,-32(s0)
	j	.L2
.L3:
	lq	a5,-48(s0)
	addi	a4,a5,1
	sq	a4,-48(s0)
	lw	a4,-52(s0)
	andi	a4,a4,0xff
	sb	a4,0(a5)
.L2:
	lq	a5,-80(s0)
	addi	a4,a5,-1
	sq	a4,-80(s0)
	bne	a5,zero,.L3
	lq	a5,-32(s0)
	mv	a0,a5
	lq	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	memset, .-memset
	.ident	"GCC: (g5eccf3e74fc) 12.1.0"
