	.file	"main.c"
	.option nopic
	.text
	.align	2
	.globl	nibu_input_func
	.type	nibu_input_func, @function
nibu_input_func:
#APP
# 8 "cfile/mandel/../header/nibuio.h" 1
	lw    a0, 4(zero);
# 0 "" 2
#NO_APP
	ret
	.size	nibu_input_func, .-nibu_input_func
	.align	2
	.globl	nibu_input
	.type	nibu_input, @function
nibu_input:
	li	a5,-1
.L4:
#APP
# 8 "cfile/mandel/../header/nibuio.h" 1
	lw    a0, 4(zero);
# 0 "" 2
#NO_APP
	beq	a0,a5,.L4
	ret
	.size	nibu_input, .-nibu_input
	.align	2
	.globl	nibu_output
	.type	nibu_output, @function
nibu_output:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a0, 4(zero);
# 0 "" 2
#NO_APP
	ret
	.size	nibu_output, .-nibu_output
	.align	2
	.globl	nibu_show
	.type	nibu_show, @function
nibu_show:
#APP
# 26 "cfile/mandel/../header/nibuio.h" 1
	sw      a0, 0(zero);
# 0 "" 2
#NO_APP
	ret
	.size	nibu_show, .-nibu_show
	.align	2
	.globl	print_string
	.type	print_string, @function
print_string:
	lbu	a5,0(a0)
	beq	a5,zero,.L8
.L10:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	lbu	a5,1(a0)
	addi	a0,a0,1
	bne	a5,zero,.L10
.L8:
	ret
	.size	print_string, .-print_string
	.align	2
	.globl	__print_int
	.type	__print_int, @function
__print_int:
	bne	a0,zero,.L17
	ret
.L17:
	tail	__print_int.part.0
	.size	__print_int, .-__print_int
	.align	2
	.type	__print_int.part.0, @function
__print_int.part.0:
	li	a5,1717985280
	addi	sp,sp,-16
	addi	a5,a5,1639
	sw	s1,4(sp)
	mulhu	s1,a0,a5
	sw	s0,8(sp)
	mv	s0,a0
	srai	a0,a0,31
	and	a5,a0,a5
	sw	ra,12(sp)
	sub	s1,s1,a5
	srai	s1,s1,2
	sub	s1,s1,a0
	mv	a0,s1
	call	__print_int
	slli	a0,s1,2
	add	a0,a0,s1
	slli	a0,a0,1
	sub	s0,s0,a0
	addi	s0,s0,48
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      s0, 4(zero);
# 0 "" 2
#NO_APP
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
	.size	__print_int.part.0, .-__print_int.part.0
	.align	2
	.globl	print_int
	.type	print_int, @function
print_int:
	blt	a0,zero,.L24
	bne	a0,zero,.L22
	li	a5,48
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	ret
.L24:
	li	a5,45
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	neg	a0,a0
.L22:
	tail	__print_int.part.0
	.size	print_int, .-print_int
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"P2\r\n"
	.align	2
.LC1:
	.string	"\r\n"
	.text
	.align	2
	.globl	init_ppm
	.type	init_ppm, @function
init_ppm:
	addi	sp,sp,-16
	lui	a5,%hi(.LC0)
	sw	s0,8(sp)
	sw	ra,12(sp)
	mv	s0,a1
	li	a4,50
	addi	a5,a5,%lo(.LC0)
	li	a3,80
	j	.L27
.L33:
	mv	a3,a4
	lbu	a4,1(a5)
.L27:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L33
	call	print_int
	li	a5,32
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	mv	a0,s0
	call	print_int
	lui	a5,%hi(.LC1)
	addi	s0,a5,%lo(.LC1)
	li	a4,10
	addi	a5,a5,%lo(.LC1)
	li	a3,13
	j	.L29
.L34:
	mv	a3,a4
	lbu	a4,1(a5)
.L29:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L34
	li	a0,255
	call	__print_int.part.0
	li	a4,10
	mv	a5,s0
	li	a3,13
	j	.L31
.L35:
	mv	a3,a4
	lbu	a4,1(a5)
.L31:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L35
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	init_ppm, .-init_ppm
	.section	.rodata.str1.4
	.align	2
.LC2:
	.string	" rl "
	.text
	.align	2
	.globl	mandel
	.type	mandel, @function
mandel:
	addi	sp,sp,-48
	sw	s2,32(sp)
	lui	s2,%hi(.LC3)
	flw	fa5,%lo(.LC3)(s2)
	sw	s0,40(sp)
	mv	s0,a0
	fmul.s	fa5,fa0,fa5
	fsw	fs2,20(sp)
	fsw	fs3,16(sp)
	fmv.s	fs2,fa0
	fmv.s	fs3,fa1
	fcvt.w.s a0,fa5,rtz
	sw	ra,44(sp)
	sw	s1,36(sp)
	fsw	fs0,28(sp)
	fsw	fs1,24(sp)
	fsw	fs4,12(sp)
	fsw	fs5,8(sp)
	call	print_int
	lui	a5,%hi(.LC2)
	li	a4,114
	addi	a5,a5,%lo(.LC2)
	li	a3,32
	j	.L38
.L49:
	mv	a3,a4
	lbu	a4,1(a5)
.L38:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L49
	flw	fa5,%lo(.LC3)(s2)
	fmul.s	fa5,fs3,fa5
	fcvt.w.s a0,fa5,rtz
	call	print_int
	lui	a5,%hi(.LC1)
	addi	s1,a5,%lo(.LC1)
	li	a4,10
	addi	a5,a5,%lo(.LC1)
	li	a3,13
	j	.L40
.L50:
	mv	a3,a4
	lbu	a4,1(a5)
.L40:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L50
	ble	s0,zero,.L45
	fmv.s.x	fs1,zero
	lui	a5,%hi(.LC4)
	flw	fs4,%lo(.LC4)(a5)
	fmv.s	fs0,fs1
	flw	fs5,%lo(.LC3)(s2)
	li	s2,0
.L41:
	fmv.s	fa5,fs0
	fmadd.s	fs0,fs0,fs0,fs2
	fadd.s	fa5,fa5,fa5
	fnmsub.s	fs0,fs1,fs1,fs0
	fmadd.s	fs1,fa5,fs1,fs3
	fmul.s	fa5,fs1,fs1
	fmadd.s	fa5,fs0,fs0,fa5
	fgt.s	a5,fa5,fs4
# bne	a5,zero,.L36
	j	.L36
	fmul.s	fa5,fs0,fs5
	fcvt.w.s a0,fa5,rtz
	call	print_int
	li	a4,10
	mv	a5,s1
	li	a3,13
	j	.L44
.L51:
	mv	a3,a4
	lbu	a4,1(a5)
.L44:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L51
	addi	s2,s2,1
	bne	s0,s2,.L41
.L45:
	mv	s2,s0
.L36:
	fmv.x.w a0, fa5
;	fmv.x.w a0, fs0
;	fmv.x.w a0, fs1
	call print_int
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	flw	fs0,28(sp)
	flw	fs1,24(sp)
	flw	fs2,20(sp)
	flw	fs3,16(sp)
	flw	fs4,12(sp)
	flw	fs5,8(sp)
	mv	a0,s2
	lw	s2,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	mandel, .-mandel
	.globl	__divsf3
	.align	2
	.globl	create_im
	.type	create_im, @function
create_im:
	addi	sp,sp,-64
	li	a1,3
	li	a0,3
	sw	s0,56(sp)
	sw	s1,52(sp)
	sw	s2,48(sp)
	fsw	fs1,24(sp)
	fsw	fs2,20(sp)
	fsw	fs3,16(sp)
	fsw	fs4,12(sp)
	sw	ra,60(sp)
	sw	s3,44(sp)
	sw	s4,40(sp)
	fsw	fs0,28(sp)
	call	init_ppm
	lui	a5,%hi(.LC5)
	flw	fs3,%lo(.LC5)(a5)
	lui	a5,%hi(.LC7)
	flw	fs4,%lo(.LC7)(a5)
	lui	a5,%hi(.LC6)
	fmv.s	fs2,fs3
	flw	fs1,%lo(.LC6)(a5)
	lui	s0,%hi(.LC1)
	li	s1,0
	addi	s0,s0,%lo(.LC1)
	li	s2,255
.L53:
	fcvt.s.w	fa0,s1
	fmv.s	fa1,fs3
	li	s3,0
	fadd.s	fa0,fa0,fa0
	li	s4,3
	call	__divsf3
	fsub.s	fs0,fa0,fs4
.L58:
	fcvt.s.w	fa0,s3
	fmv.s	fa1,fs2
	fadd.s	fa0,fa0,fa0
	call	__divsf3
	fmv.s	fa1,fa0
	fmv.s	fa0,fs0
	li	a0,256
	fsub.s	fa1,fa1,fs1
	call	mandel
	mv	a5,a0
	li	a4,256
	li	a0,0
	beq	a5,a4,.L54
	mv	a0,a5
	ble	a5,s2,.L54
	li	a0,255
.L54:
	call	print_int
	li	a4,10
	mv	a5,s0
	li	a3,13
	j	.L57
.L65:
	mv	a3,a4
	lbu	a4,1(a5)
.L57:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L65
	addi	s3,s3,1
	bne	s3,s4,.L58
	li	a4,10
	mv	a5,s0
	li	a3,13
	j	.L60
.L66:
	mv	a3,a4
	lbu	a4,1(a5)
.L60:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L66
	addi	s1,s1,1
	li	a5,3
	bne	s1,a5,.L53
	lw	ra,60(sp)
	lw	s0,56(sp)
	lw	s1,52(sp)
	lw	s2,48(sp)
	lw	s3,44(sp)
	lw	s4,40(sp)
	flw	fs0,28(sp)
	flw	fs1,24(sp)
	flw	fs2,20(sp)
	flw	fs3,16(sp)
	flw	fs4,12(sp)
	li	a0,0
	addi	sp,sp,64
	jr	ra
	.size	create_im, .-create_im
	.align	2
	.globl	test
	.type	test, @function
test:
	lui	a5,%hi(.LC8)
	flw	fa1,%lo(.LC8)(a5)
	lui	a5,%hi(.LC9)
	flw	fa0,%lo(.LC9)(a5)
	addi	sp,sp,-16
	li	a0,256
	sw	ra,12(sp)
	call	mandel
	mv	a5,a0
	li	a4,256
	li	a0,0
	beq	a5,a4,.L68
	mv	a0,a5
	li	a5,255
	bgt	a0,a5,.L74
.L68:
	call	print_int
	lui	a5,%hi(.LC1)
	li	a4,10
	addi	a5,a5,%lo(.LC1)
	li	a3,13
	j	.L71
.L75:
	mv	a3,a4
	lbu	a4,1(a5)
.L71:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L75
	lw	ra,12(sp)
	addi	sp,sp,16
	jr	ra
.L74:
	li	a0,255
	j	.L68
	.size	test, .-test
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	test
	lw	ra,12(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC3:
	.word	1120403456
	.align	2
.LC4:
	.word	1082130432
	.align	2
.LC5:
	.word	1077936128
	.align	2
.LC6:
	.word	1065353216
	.align	2
.LC7:
	.word	1069547520
	.align	2
.LC8:
	.word	3212836864
	.align	2
.LC9:
	.word	3190467240
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
