	.file	"fdiv_check.c"
	.option nopic
	.text
	.align	2
	.globl	nibu_input_func
	.type	nibu_input_func, @function
nibu_input_func:
#APP
# 8 "cfile/fdiv/../header/nibuio.h" 1
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
# 8 "cfile/fdiv/../header/nibuio.h" 1
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
# 21 "cfile/fdiv/../header/nibuio.h" 1
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
# 26 "cfile/fdiv/../header/nibuio.h" 1
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
# 21 "cfile/fdiv/../header/nibuio.h" 1
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
# 21 "cfile/fdiv/../header/nibuio.h" 1
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
# 21 "cfile/fdiv/../header/nibuio.h" 1
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
# 21 "cfile/fdiv/../header/nibuio.h" 1
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
# 21 "cfile/fdiv/../header/nibuio.h" 1
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
	.globl	clzsi2
	.type	clzsi2, @function
clzsi2:
	li	a5,-65536
	and	a5,a0,a5
	li	a4,16
	beq	a5,zero,.L33
	srli	a0,a0,16
	li	a4,0
.L33:
	li	a5,65536
	addi	a5,a5,-256
	and	a5,a0,a5
	beq	a5,zero,.L34
	srli	a0,a0,8
	andi	a5,a0,240
	beq	a5,zero,.L36
.L42:
	srli	a0,a0,4
	andi	a5,a0,12
	beq	a5,zero,.L38
.L43:
	srli	a0,a0,2
.L39:
	srli	a5,a0,1
	xori	a5,a5,1
	li	a3,2
	andi	a5,a5,1
	neg	a5,a5
	sub	a0,a3,a0
	and	a0,a5,a0
	add	a0,a0,a4
	ret
.L34:
	andi	a5,a0,240
	addi	a4,a4,8
	bne	a5,zero,.L42
.L36:
	andi	a5,a0,12
	addi	a4,a4,4
	bne	a5,zero,.L43
.L38:
	addi	a4,a4,2
	j	.L39
	.size	clzsi2, .-clzsi2
	.align	2
	.globl	test__divsf3
	.type	test__divsf3, @function
test__divsf3:
	addi	sp,sp,-32
	fmv.x.s	a5,fa0
	sw	s0,24(sp)
	fmv.x.s	s0,fa1
	srai	a1,a5,23
	sw	s3,12(sp)
	srai	a0,s0,23
	li	a4,8388608
	andi	s3,a1,255
	addi	a4,a4,-1
	sw	s1,20(sp)
	sw	s2,16(sp)
	sw	s4,8(sp)
	sw	s5,4(sp)
	xor	s2,a5,s0
	andi	s4,a0,255
	sw	ra,28(sp)
	li	a0,-2147483648
	sw	s6,0(sp)
	addi	a2,s3,-1
	li	a3,253
	and	s2,s2,a0
	and	s5,a4,a5
	and	s1,a4,s0
	bgtu	a2,a3,.L45
	addi	a4,s4,-1
	bgtu	a4,a3,.L45
	li	a3,0
.L46:
	li	a5,8388608
	or	a4,s1,a5
	li	a6,1963257856
	slli	a2,a4,8
	addi	a6,a6,819
	sub	a7,a6,a2
	mulhu	a6,a7,a2
	sub	a1,s3,s4
	add	a1,a1,a3
	or	s1,s5,a5
	slli	t1,s1,1
	li	a5,16777216
	neg	a6,a6
	mul	a0,a6,a7
	mulhu	a6,a6,a7
	srli	a7,a0,31
	slli	a6,a6,1
	or	a7,a6,a7
	mulhu	a0,a2,a7
	neg	a0,a0
	mul	a6,a0,a7
	mulhu	a0,a0,a7
	srli	a6,a6,31
	slli	a0,a0,1
	or	a6,a0,a6
	mulhu	a2,a2,a6
	neg	a2,a2
	mul	a3,a2,a6
	mulhu	a2,a2,a6
	srli	a3,a3,31
	slli	a2,a2,1
	or	a3,a2,a3
	addi	a3,a3,-2
	mulhsu	a3,t1,a3
	blt	a3,a5,.L70
	srai	a3,a3,1
	mul	a5,a4,a3
	slli	s1,s1,23
	addi	a1,a1,127
	sub	s1,s1,a5
	li	a5,254
	bgt	a1,a5,.L71
.L58:
	bgt	a1,zero,.L59
	bne	a1,zero,.L60
	li	a5,8388608
	addi	a2,a5,-1
	slli	s1,s1,1
	slt	a4,a4,s1
	and	a3,a3,a2
	add	a3,a4,a3
	li	a4,-8388608
	and	a3,a3,a4
	or	a5,s2,a5
	bne	a3,zero,.L44
.L60:
	mv	a5,s2
	j	.L44
.L45:
	li	a3,-2147483648
	xori	a3,a3,-1
	and	a2,a3,a5
	li	a4,2139095040
	bgt	a2,a4,.L72
	and	a3,a3,s0
	bgt	a3,a4,.L73
	beq	a2,a4,.L74
	beq	a3,a4,.L60
	bne	a2,zero,.L52
	bne	a3,zero,.L60
.L63:
	lui	a5,%hi(.LC0)
	lw	a5,%lo(.LC0)(a5)
	j	.L44
.L72:
	li	s0,4194304
	or	a5,s0,a5
.L44:
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	lw	s5,4(sp)
	lw	s6,0(sp)
	fmv.s.x	fa0,a5
	addi	sp,sp,32
	jr	ra
.L70:
	mul	a2,a4,a3
	slli	a5,s1,24
	addi	a1,a1,-1
	addi	a1,a1,127
	sub	s1,a5,a2
	li	a5,254
	ble	a1,a5,.L58
.L71:
	li	a5,2139095040
	or	a5,s2,a5
	j	.L44
.L73:
	li	a5,4194304
	or	a5,a5,s0
	j	.L44
.L74:
	or	a5,s2,a2
	bne	a3,a2,.L44
	j	.L63
.L59:
	slli	a3,a3,9
	srli	a3,a3,9
	slli	a1,a1,23
	slli	s1,s1,1
	or	a3,a1,a3
	slt	s1,a4,s1
	add	a3,s1,a3
	or	a5,a3,s2
	j	.L44
.L52:
	beq	a3,zero,.L75
	and	a5,a4,a5
	li	s6,0
	beq	a5,zero,.L76
.L54:
	li	a5,2139095040
	and	s0,a5,s0
	mv	a3,s6
	bne	s0,zero,.L46
	mv	a0,s1
	call	clzsi2
	addi	a0,a0,-8
	add	a3,s6,a0
	sll	s1,s1,a0
	addi	a3,a3,-1
	j	.L46
.L76:
	mv	a0,s5
	call	clzsi2
	addi	s6,a0,-8
	li	a3,1
	sll	s5,s5,s6
	sub	s6,a3,s6
	j	.L54
.L75:
	or	a5,s2,a4
	j	.L44
	.size	test__divsf3, .-test__divsf3
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC1:
	.string	"\r\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	s1,4(sp)
	lui	s1,%hi(.LC1)
	sw	s0,8(sp)
	sw	ra,12(sp)
	addi	s1,s1,%lo(.LC1)
	li	s0,-1
.L78:
#APP
# 8 "cfile/fdiv/../header/nibuio.h" 1
	lw    a5, 4(zero);
# 0 "" 2
#NO_APP
	beq	a5,s0,.L78
	addi	a5,a5,-48
	fcvt.s.w	fa0,a5
.L79:
#APP
# 8 "cfile/fdiv/../header/nibuio.h" 1
	lw    a5, 4(zero);
# 0 "" 2
#NO_APP
	beq	a5,s0,.L79
	addi	a5,a5,-48
	fcvt.s.w	fa1,a5
	call	test__divsf3
	fcvt.w.s a0,fa0,rtz
	call	print_int
	li	a4,10
	mv	a5,s1
	li	a3,13
	j	.L81
.L87:
	mv	a3,a4
	lbu	a4,1(a5)
.L81:
#APP
# 21 "cfile/fdiv/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L87
	j	.L78
	.size	main, .-main
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC0:
	.word	2143289344
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
