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
	sw	ra,12(sp)
	li	a4,50
	addi	a5,a5,%lo(.LC0)
	li	a3,80
	j	.L27
.L31:
	mv	a3,a4
	lbu	a4,1(a5)
.L27:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L31
	li	a0,35
	call	__print_int.part.0
	li	a5,32
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	li	a0,-40
	call	print_int
	lui	a5,%hi(.LC1)
	li	a4,10
	addi	a5,a5,%lo(.LC1)
	li	a3,13
	j	.L29
.L32:
	mv	a3,a4
	lbu	a4,1(a5)
.L29:
#APP
# 21 "cfile/mandel/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L32
	lw	ra,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	init_ppm, .-init_ppm
	.align	2
	.globl	mandel
	.type	mandel, @function
mandel:
	ble	a0,zero,.L34
	fmv.s.x	fa5,zero
	lui	a5,%hi(.LC2)
	fadd.s	fa1,fa1,fa5
	fadd.s	fa0,fa0,fa5
	flw	fa5,%lo(.LC2)(a5)
	fmul.s	fa1,fa1,fa1
	fmadd.s	fa0,fa0,fa0,fa1
	fgt.s	a5,fa0,fa5
	addi	a5,a5,-1
	and	a0,a0,a5
.L34:
	ret
	.size	mandel, .-mandel
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	li	a0,256
	li	a1,256
	sw	ra,12(sp)
	call	init_ppm
	lw	ra,12(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC2:
	.word	1082130432
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
