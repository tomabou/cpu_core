	.file	"fibo.c"
	.option nopic
	.text
	.align	2
	.globl	nibu_input_func
	.type	nibu_input_func, @function
nibu_input_func:
#APP
# 8 "cfile/fibo/../header/nibuio.h" 1
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
# 8 "cfile/fibo/../header/nibuio.h" 1
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
# 21 "cfile/fibo/../header/nibuio.h" 1
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
# 26 "cfile/fibo/../header/nibuio.h" 1
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
# 21 "cfile/fibo/../header/nibuio.h" 1
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
# 21 "cfile/fibo/../header/nibuio.h" 1
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
# 21 "cfile/fibo/../header/nibuio.h" 1
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
# 21 "cfile/fibo/../header/nibuio.h" 1
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
# 21 "cfile/fibo/../header/nibuio.h" 1
	sw      s0, 4(zero);
# 0 "" 2
#NO_APP
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
	.size	print_int, .-print_int
	.align	2
	.globl	fibo
	.type	fibo, @function
fibo:
	li	a5,1
	ble	a0,a5,.L40
	addi	sp,sp,-16
	addi	a5,a0,-2
	sw	s2,0(sp)
	andi	a5,a5,-2
	addi	s2,a0,-3
	sw	s0,8(sp)
	sw	s1,4(sp)
	sw	ra,12(sp)
	addi	s0,a0,-1
	sub	s2,s2,a5
	li	s1,0
.L34:
	mv	a0,s0
	call	fibo
	addi	s0,s0,-2
	add	s1,s1,a0
	bne	s0,s2,.L34
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s2,0(sp)
	addi	a0,s1,1
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
.L40:
	li	a0,1
	ret
	.size	fibo, .-fibo
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"input number!\r\n"
	.align	2
.LC1:
	.string	"anser is "
	.align	2
.LC2:
	.string	" \r\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	s4,24(sp)
	sw	s5,20(sp)
	sw	s6,16(sp)
	lui	s4,%hi(.LC0)
	lui	s6,%hi(.LC1)
	lui	s5,%hi(.LC2)
	sw	s1,36(sp)
	sw	s2,32(sp)
	sw	s3,28(sp)
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s7,12(sp)
	addi	s4,s4,%lo(.LC0)
	addi	s6,s6,%lo(.LC1)
	addi	s5,s5,%lo(.LC2)
	li	s1,-1
	li	s3,9
	li	s2,1
.L42:
#APP
# 8 "cfile/fibo/../header/nibuio.h" 1
	lw    a5, 4(zero);
# 0 "" 2
#NO_APP
	beq	a5,s1,.L42
	addi	s0,a5,-48
	bleu	s0,s3,.L43
	li	a4,110
	mv	a5,s4
	li	a3,105
	j	.L45
.L60:
	mv	a3,a4
	lbu	a4,1(a5)
.L45:
#APP
# 21 "cfile/fibo/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L60
	j	.L42
.L43:
	li	s7,0
	ble	s0,s2,.L61
.L46:
	addi	a0,s0,-1
	call	fibo
	addi	s0,s0,-2
	add	s7,s7,a0
	bgt	s0,s2,.L46
	addi	s7,s7,49
.L48:
	li	a4,110
	mv	a5,s6
	li	a3,97
	j	.L47
.L49:
	lbu	a4,1(a5)
.L47:
#APP
# 21 "cfile/fibo/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	mv	a3,a4
	addi	a5,a5,1
	bne	a4,zero,.L49
#APP
# 21 "cfile/fibo/../header/nibuio.h" 1
	sw      s7, 4(zero);
# 0 "" 2
#NO_APP
	li	a4,13
	mv	a5,s5
	li	a3,32
	j	.L50
.L62:
	mv	a3,a4
	lbu	a4,1(a5)
.L50:
#APP
# 21 "cfile/fibo/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L62
	j	.L42
.L61:
	li	s7,49
	j	.L48
	.size	main, .-main
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
