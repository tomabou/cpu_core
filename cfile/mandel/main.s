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
	.align	2
	.globl	mandel
	.type	mandel, @function
mandel:
	ble	a0,zero,.L37
	fmv.s.x	fa4,zero
	lui	a5,%hi(.LC2)
	flw	fa2,%lo(.LC2)(a5)
	fmv.s	fa5,fa4
	li	a4,0
	j	.L38
.L42:
	addi	a4,a4,1
	beq	a0,a4,.L41
.L38:
	fmv.s	fa3,fa5
	fmadd.s	fa5,fa5,fa5,fa0
	fadd.s	fa3,fa3,fa3
	fnmsub.s	fa5,fa4,fa4,fa5
	fmadd.s	fa4,fa3,fa4,fa1
	fmul.s	fa3,fa4,fa4
	fmadd.s	fa3,fa5,fa5,fa3
	fgt.s	a5,fa3,fa2
	beq	a5,zero,.L42
	mv	a0,a4
.L37:
	ret
.L41:
	ret
	.size	mandel, .-mandel
	.align	2
	.globl	create_im
	.type	create_im, @function
create_im:
	addi	sp,sp,-64
	li	a1,256
	li	a0,256
	sw	s1,52(sp)
	sw	s2,48(sp)
	sw	s3,44(sp)
	fsw	fs1,24(sp)
	fsw	fs2,20(sp)
	fsw	fs3,16(sp)
	fsw	fs4,12(sp)
	fsw	fs5,8(sp)
	sw	ra,60(sp)
	sw	s0,56(sp)
	sw	s4,40(sp)
	fsw	fs0,28(sp)
	call	init_ppm
	lui	a5,%hi(.LC3)
	flw	fs3,%lo(.LC3)(a5)
	lui	a5,%hi(.LC5)
	flw	fs4,%lo(.LC5)(a5)
	lui	a5,%hi(.LC4)
	flw	fs1,%lo(.LC4)(a5)
	lui	a5,%hi(.LC2)
	fmv.s	fs2,fs3
	flw	fs5,%lo(.LC2)(a5)
	lui	s2,%hi(.LC1)
	li	s1,0
	addi	s2,s2,%lo(.LC1)
	li	s3,256
.L44:
	fcvt.s.w	fs0,s1
	li	s4,0
	li	s0,255
	fadd.s	fs0,fs0,fs0
	fmadd.s	fs0,fs0,fs3,fs4
.L49:
	fcvt.s.w	fa2,s4
	fmv.s.x	fa4,zero
	li	a4,0
	fadd.s	fa2,fa2,fa2
	fmv.s	fa5,fa4
	fmadd.s	fa2,fa2,fs2,fs1
.L46:
	fmv.s	fa3,fa5
	fmadd.s	fa5,fa5,fa5,fs0
	fadd.s	fa3,fa3,fa3
	fnmsub.s	fa5,fa4,fa4,fa5
	fmadd.s	fa4,fa3,fa4,fa2
	fmul.s	fa3,fa4,fa4
	fmadd.s	fa3,fa5,fa5,fa3
	fgt.s	a5,fa3,fs5
	bne	a5,zero,.L45
	addi	a4,a4,1
	bne	a4,s3,.L46
	li	a0,0
.L47:
	call	print_int
	li	a5,32
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	addi	s4,s4,1
	bne	s4,s3,.L49
	li	a4,10
	mv	a5,s2
	li	a3,13
	j	.L51
.L56:
	mv	a3,a4
	lbu	a4,1(a5)
.L51:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L56
	addi	s1,s1,1
	bne	s1,s3,.L44
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
	flw	fs5,8(sp)
	li	a0,0
	addi	sp,sp,64
	jr	ra
.L45:
	slli	a0,a4,2
	add	a4,a0,a4
	slli	a0,a4,1
	ble	a0,s0,.L47
	li	a0,255
	j	.L47
	.size	create_im, .-create_im
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	create_im
	lw	ra,12(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC2:
	.word	1082130432
	.align	2
.LC3:
	.word	998244352
	.align	2
.LC4:
	.word	3212836864
	.align	2
.LC5:
	.word	3217031168
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
