	.file	"send.c"
	.option nopic
	.text
	.align	2
	.globl	nibu_input_func
	.type	nibu_input_func, @function
nibu_input_func:
#APP
# 8 "cfile/test/../header/nibuio.h" 1
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
# 8 "cfile/test/../header/nibuio.h" 1
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
# 21 "cfile/test/../header/nibuio.h" 1
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
# 26 "cfile/test/../header/nibuio.h" 1
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
# 21 "cfile/test/../header/nibuio.h" 1
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
	bne	a0,zero,.L24
	ret
.L24:
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
# 21 "cfile/test/../header/nibuio.h" 1
	sw      s0, 4(zero);
# 0 "" 2
#NO_APP
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
	.size	__print_int, .-__print_int
	.align	2
	.globl	print_int
	.type	print_int, @function
print_int:
	addi	sp,sp,-16
	sw	s0,8(sp)
	sw	ra,12(sp)
	sw	s1,4(sp)
	mv	s0,a0
	blt	a0,zero,.L31
	bne	a0,zero,.L27
	li	a5,48
#APP
# 21 "cfile/test/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
.L31:
	li	a5,45
#APP
# 21 "cfile/test/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	neg	s0,a0
.L27:
	li	s1,-858992640
	addi	s1,s1,-819
	mulhu	s1,s0,s1
	srli	s1,s1,3
	mv	a0,s1
	call	__print_int
	slli	a0,s1,2
	add	a0,a0,s1
	slli	a0,a0,1
	sub	s0,s0,a0
	addi	s0,s0,48
#APP
# 21 "cfile/test/../header/nibuio.h" 1
	sw      s0, 4(zero);
# 0 "" 2
#NO_APP
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
	.size	print_int, .-print_int
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"\r\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	s2,16(sp)
	lui	s2,%hi(.LC0)
	sw	s0,24(sp)
	sw	s1,20(sp)
	sw	s3,12(sp)
	sw	ra,28(sp)
	li	s1,0
	addi	s2,s2,%lo(.LC0)
	li	s0,123
	li	s3,100
.L33:
	li	a5,97
.L34:
#APP
# 21 "cfile/test/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	addi	a4,a5,-32
#APP
# 21 "cfile/test/../header/nibuio.h" 1
	sw      a4, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a5,s0,.L34
	mv	a0,s1
	call	print_int
	li	a4,10
	mv	a5,s2
	li	a3,13
	j	.L36
.L40:
	mv	a3,a4
	lbu	a4,1(a5)
.L36:
#APP
# 21 "cfile/test/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L40
	addi	s1,s1,1
	bne	s1,s3,.L33
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
