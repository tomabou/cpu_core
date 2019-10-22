	.file	"main.c"
	.option nopic
	.text
	.align	2
	.globl	nibu_input_func
	.type	nibu_input_func, @function
nibu_input_func:
#APP
# 8 "cfile/brainf*ck/../header/nibuio.h" 1
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
# 8 "cfile/brainf*ck/../header/nibuio.h" 1
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
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
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
# 26 "cfile/brainf*ck/../header/nibuio.h" 1
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
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
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
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
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
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
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
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
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
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
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
	.globl	switch_func
	.type	switch_func, @function
switch_func:
	lw	a4,0(a0)
	lw	a4,0(a4)
	beq	a4,zero,.L42
	li	a3,62
	beq	a4,a3,.L48
	li	a3,60
	beq	a4,a3,.L49
	li	a3,43
	beq	a4,a3,.L50
	li	a3,45
	beq	a4,a3,.L51
	li	a3,46
	beq	a4,a3,.L52
	li	a3,44
	beq	a4,a3,.L53
	addi	a3,a4,-93
	li	a5,91
	seqz	a3,a3
	bne	a4,a5,.L45
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	loop_func
	lw	ra,12(sp)
	li	a3,0
	mv	a0,a3
	addi	sp,sp,16
	jr	ra
.L48:
	lw	a4,0(a1)
	li	a3,0
	addi	a4,a4,4
	sw	a4,0(a1)
.L45:
	mv	a0,a3
	ret
.L42:
	li	a3,1
	mv	a0,a3
	ret
.L50:
	lw	a4,0(a1)
	li	a3,0
	lw	a5,0(a4)
	addi	a5,a5,1
	sw	a5,0(a4)
	j	.L45
.L49:
	lw	a4,0(a1)
	li	a3,0
	mv	a0,a3
	addi	a4,a4,-4
	sw	a4,0(a1)
	ret
.L51:
	lw	a4,0(a1)
	li	a3,0
	lw	a5,0(a4)
	addi	a5,a5,-1
	sw	a5,0(a4)
	j	.L45
.L52:
	lw	a5,0(a1)
	lw	a5,0(a5)
#APP
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	li	a3,0
	j	.L45
.L53:
	lw	a3,0(a1)
	li	a4,-1
.L40:
#APP
# 8 "cfile/brainf*ck/../header/nibuio.h" 1
	lw    a5, 4(zero);
# 0 "" 2
#NO_APP
	beq	a5,a4,.L40
	sw	a5,0(a3)
	li	a3,0
	j	.L45
	.size	switch_func, .-switch_func
	.align	2
	.globl	main_func
	.type	main_func, @function
main_func:
	lui	a5,%hi(workspace)
	li	a4,4096
	addi	sp,sp,-32
	addi	a3,a5,%lo(workspace)
	addi	a4,a4,-96
	sw	ra,28(sp)
	sw	a0,8(sp)
	addi	a5,a5,%lo(workspace)
	add	a4,a3,a4
.L55:
	sw	zero,0(a5)
	addi	a5,a5,4
	bne	a5,a4,.L55
	sw	a3,12(sp)
	j	.L57
.L60:
	lw	a5,8(sp)
	addi	a5,a5,4
	sw	a5,8(sp)
.L57:
	addi	a1,sp,12
	addi	a0,sp,8
	call	switch_func
	beq	a0,zero,.L60
	lw	ra,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	main_func, .-main_func
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"\r\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(sorce)
	addi	a4,a0,%lo(sorce)
	addi	sp,sp,-16
	lui	a5,%hi(global_start)
	sw	a4,%lo(global_start)(a5)
	sw	ra,12(sp)
	addi	a3,a0,%lo(sorce)
	li	a4,-1
	li	a2,64
.L63:
#APP
# 8 "cfile/brainf*ck/../header/nibuio.h" 1
	lw    a5, 4(zero);
# 0 "" 2
#NO_APP
	beq	a5,a4,.L63
	beq	a5,a2,.L69
	sw	a5,0(a3)
#APP
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
	sw      a5, 4(zero);
# 0 "" 2
#NO_APP
	addi	a3,a3,4
	j	.L63
.L69:
	lui	a5,%hi(.LC0)
	li	a4,10
	addi	a5,a5,%lo(.LC0)
	li	a3,13
	j	.L66
.L70:
	mv	a3,a4
	lbu	a4,1(a5)
.L66:
#APP
# 21 "cfile/brainf*ck/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L70
	addi	a0,a0,%lo(sorce)
	call	main_func
	lw	ra,12(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.text
	.align	2
	.globl	loop_func
	.type	loop_func, @function
loop_func:
	lw	a5,0(a1)
	addi	sp,sp,-16
	sw	s2,0(sp)
	lw	a5,0(a5)
	lw	s2,0(a0)
	sw	s0,8(sp)
	sw	s1,4(sp)
	sw	ra,12(sp)
	mv	s0,a0
	addi	s2,s2,4
	mv	s1,a1
	beq	a5,zero,.L76
.L72:
	sw	s2,0(s0)
	j	.L75
.L86:
	lw	a5,0(s0)
	addi	a5,a5,4
	sw	a5,0(s0)
.L75:
	mv	a1,s1
	mv	a0,s0
	call	switch_func
	beq	a0,zero,.L86
	lw	a5,0(s1)
	lw	a5,0(a5)
	bne	a5,zero,.L72
.L76:
	lw	a4,0(s2)
	li	a1,93
	li	a3,1
	addi	a5,a4,-91
	addi	a2,s2,4
	seqz	a5,a5
	beq	a4,a1,.L87
.L77:
	add	a3,a3,a5
.L80:
	mv	s2,a2
	lw	a4,0(s2)
	addi	a2,s2,4
	addi	a5,a4,-91
	seqz	a5,a5
	bne	a4,a1,.L77
.L87:
	addi	a3,a3,-1
	bne	a3,zero,.L80
	sw	s2,0(s0)
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	lw	s2,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	loop_func, .-loop_func
	.comm	workspace,4000,4
	.comm	sorce,4000,4
	.comm	global_start,4,4
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
