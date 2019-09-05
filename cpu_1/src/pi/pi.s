	.file	"pi.c"
	.option nopic
	.text
	.align	2
	.globl	leibniz
	.type	leibniz, @function
leibniz:
	fmv.s.x	fa0,zero
	ble	a0,zero,.L6
	lui	a5,%hi(.LC0)
	fld	fa4,%lo(.LC0)(a5)
	li	a3,1
	li	a5,0
	j	.L5
.L10:
	fadd.d	fa0,fa0,fa5
	addi	a5,a5,1
	addi	a3,a3,2
	fcvt.s.d	fa0,fa0
	beq	a0,a5,.L9
.L5:
	fcvt.d.w	fa5,a3
	andi	a4,a5,1
	fcvt.d.s	fa0,fa0
	fdiv.d	fa5,fa4,fa5
	beq	a4,zero,.L10
	fsub.d	fa0,fa0,fa5
	addi	a5,a5,1
	addi	a3,a3,2
	fcvt.s.d	fa0,fa0
	bne	a0,a5,.L5
.L9:
	lui	a5,%hi(.LC1)
	flw	fa5,%lo(.LC1)(a5)
	fmul.s	fa0,fa0,fa5
	ret
.L6:
	ret
	.size	leibniz, .-leibniz
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC0:
	.word	0
	.word	1072693248
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC1:
	.word	1082130432
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
