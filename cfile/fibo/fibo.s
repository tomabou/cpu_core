	.file	"fibo.c"
	.option nopic
	.text
	.align	2
	.globl	nibu_input_func
	.type	nibu_input_func, @function
nibu_input_func:
#APP
# 6 "cfile/fibo/../header/nibuio.h" 1
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
# 6 "cfile/fibo/../header/nibuio.h" 1
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
# 19 "cfile/fibo/../header/nibuio.h" 1
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
# 24 "cfile/fibo/../header/nibuio.h" 1
	sw      a0, 0(zero);
# 0 "" 2
#NO_APP
	ret
	.size	nibu_show, .-nibu_show
	.align	2
	.globl	fibo
	.type	fibo, @function
fibo:
	li	a5,1
	ble	a0,a5,.L16
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
.L10:
	mv	a0,s0
	call	fibo
	addi	s0,s0,-2
	add	s1,s1,a0
	bne	s0,s2,.L10
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s2,0(sp)
	addi	a0,s1,1
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
.L16:
	li	a0,1
	ret
	.size	fibo, .-fibo
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	sw	s1,4(sp)
	sw	s2,0(sp)
	li	a5,-1
.L18:
#APP
# 6 "cfile/fibo/../header/nibuio.h" 1
	lw    a0, 4(zero);
# 0 "" 2
#NO_APP
	beq	a0,a5,.L18
	li	a5,1
	li	s1,0
	ble	a0,a5,.L20
	addi	a5,a0,-2
	addi	s2,a0,-3
	andi	a5,a5,-2
	addi	s0,a0,-1
	sub	s2,s2,a5
	li	s1,0
.L21:
	mv	a0,s0
	call	fibo
	addi	s0,s0,-2
	add	s1,s1,a0
	bne	s0,s2,.L21
.L20:
	addi	s1,s1,1
#APP
# 19 "cfile/fibo/../header/nibuio.h" 1
	sw      s1, 4(zero);
# 0 "" 2
#NO_APP
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	lw	s2,0(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
