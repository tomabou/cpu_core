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
	.globl	fibo
	.type	fibo, @function
fibo:
	li	a5,1
	ble	a0,a5,.L23
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
.L17:
	mv	a0,s0
	call	fibo
	addi	s0,s0,-2
	add	s1,s1,a0
	bne	s0,s2,.L17
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s2,0(sp)
	addi	a0,s1,1
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
.L23:
	li	a0,1
	ret
	.size	fibo, .-fibo
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"this is fibo"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a5,%hi(.LC0)
	li	a4,104
	addi	a5,a5,%lo(.LC0)
	li	a3,116
	j	.L26
.L27:
	mv	a3,a4
	lbu	a4,1(a5)
.L26:
#APP
# 21 "cfile/fibo/../header/nibuio.h" 1
	sw      a3, 4(zero);
# 0 "" 2
#NO_APP
	addi	a5,a5,1
	bne	a4,zero,.L27
	li	a0,0
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits
