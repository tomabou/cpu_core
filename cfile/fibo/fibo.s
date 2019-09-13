	.file	"fibo.c"
	.option nopic
	.text
	.align	2
	.globl	fibo
	.type	fibo, @function
fibo:
	li	a5,1
	ble	a0,a5,.L10
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
.L3:
	mv	a0,s0
	call	fibo
	addi	s0,s0,-2
	add	s1,s1,a0
	bne	s0,s2,.L3
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s2,0(sp)
	addi	a0,s1,1
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
.L10:
	li	a0,1
	ret
	.size	fibo, .-fibo
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	s1,4(sp)
	sw	ra,12(sp)
	sw	s0,8(sp)
	sw	s2,0(sp)
	call	nibu_input
	li	a5,1
	li	s1,0
	ble	a0,a5,.L13
	addi	a5,a0,-2
	addi	s2,a0,-3
	andi	a5,a5,-2
	addi	s0,a0,-1
	sub	s2,s2,a5
	li	s1,0
.L14:
	mv	a0,s0
	call	fibo
	addi	s0,s0,-2
	add	s1,s1,a0
	bne	s0,s2,.L14
.L13:
	addi	a0,s1,1
	call	nibu_output
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
