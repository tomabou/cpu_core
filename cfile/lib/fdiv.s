
clzsi2:
	li	a5,-65536
	and	a5,a0,a5
	li	a4,16
	beq	a5,zero,.L__divsf3__2
	srli	a0,a0,16
	li	a4,0
.L__divsf3__2:
	li	a5,65536
	addi	a5,a5,-256
	and	a5,a0,a5
	beq	a5,zero,.L__divsf3__3
	srli	a0,a0,8
	andi	a5,a0,240
	beq	a5,zero,.L__divsf3__5
.L__divsf3__12:
	srli	a0,a0,4
	andi	a5,a0,12
	beq	a5,zero,.L__divsf3__7
.L__divsf3__13:
	srli	a0,a0,2
.L__divsf3__8:
	srli	a5,a0,1
	xori	a5,a5,1
	li	a3,2
	andi	a5,a5,1
	neg	a5,a5
	sub	a0,a3,a0
	and	a0,a5,a0
	add	a0,a0,a4
	ret
.L__divsf3__3:
	andi	a5,a0,240
	addi	a4,a4,8
	bne	a5,zero,.L__divsf3__12
.L__divsf3__5:
	andi	a5,a0,12
	addi	a4,a4,4
	bne	a5,zero,.L__divsf3__13
.L__divsf3__7:
	addi	a4,a4,2
	j	.L__divsf3__8
__divsf3:
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
	bgtu	a2,a3,.L__divsf3__15
	addi	a4,s4,-1
	bgtu	a4,a3,.L__divsf3__15
	li	a3,0
.L__divsf3__16:
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
	blt	a3,a5,.L__divsf3__40
	srai	a3,a3,1
	mul	a5,a4,a3
	slli	s1,s1,23
	addi	a1,a1,127
	sub	s1,s1,a5
	li	a5,254
	bgt	a1,a5,.L__divsf3__41
.L__divsf3__28:
	bgt	a1,zero,.L__divsf3__29
	bne	a1,zero,.L__divsf3__30
	li	a5,8388608
	addi	a2,a5,-1
	slli	s1,s1,1
	slt	a4,a4,s1
	and	a3,a3,a2
	add	a3,a4,a3
	li	a4,-8388608
	and	a3,a3,a4
	or	a5,s2,a5
	bne	a3,zero,.L__divsf3__14
.L__divsf3__30:
	mv	a5,s2
	j	.L__divsf3__14
.L__divsf3__15:
	li	a3,-2147483648
	xori	a3,a3,-1
	and	a2,a3,a5
	li	a4,2139095040
	bgt	a2,a4,.L__divsf3__42
	and	a3,a3,s0
	bgt	a3,a4,.L__divsf3__43
	beq	a2,a4,.L__divsf3__44
	beq	a3,a4,.L__divsf3__30
	bne	a2,zero,.L__divsf3__22
	bne	a3,zero,.L__divsf3__30
.L__divsf3__33:
	lui	a5,%hi(.L__divsf3__C0)
	lw	a5,%lo(.L__divsf3__C0)(a5)
	j	.L__divsf3__14
.L__divsf3__42:
	li	s0,4194304
	or	a5,s0,a5
.L__divsf3__14:
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
.L__divsf3__40:
	mul	a2,a4,a3
	slli	a5,s1,24
	addi	a1,a1,-1
	addi	a1,a1,127
	sub	s1,a5,a2
	li	a5,254
	ble	a1,a5,.L__divsf3__28
.L__divsf3__41:
	li	a5,2139095040
	or	a5,s2,a5
	j	.L__divsf3__14
.L__divsf3__43:
	li	a5,4194304
	or	a5,a5,s0
	j	.L__divsf3__14
.L__divsf3__44:
	or	a5,s2,a2
	bne	a3,a2,.L__divsf3__14
	j	.L__divsf3__33
.L__divsf3__29:
	slli	a3,a3,9
	srli	a3,a3,9
	slli	a1,a1,23
	slli	s1,s1,1
	or	a3,a1,a3
	slt	s1,a4,s1
	add	a3,s1,a3
	or	a5,a3,s2
	j	.L__divsf3__14
.L__divsf3__22:
	beq	a3,zero,.L__divsf3__45
	and	a5,a4,a5
	li	s6,0
	beq	a5,zero,.L__divsf3__46
.L__divsf3__24:
	li	a5,2139095040
	and	s0,a5,s0
	mv	a3,s6
	bne	s0,zero,.L__divsf3__16
	mv	a0,s1
	call	clzsi2
	addi	a0,a0,-8
	add	a3,s6,a0
	sll	s1,s1,a0
	addi	a3,a3,-1
	j	.L__divsf3__16
.L__divsf3__46:
	mv	a0,s5
	call	clzsi2
	addi	s6,a0,-8
	li	a3,1
	sll	s5,s5,s6
	sub	s6,a3,s6
	j	.L__divsf3__24
.L__divsf3__45:
	or	a5,s2,a4
	j	.L__divsf3__14
.L__divsf3__C0:
	.word	2143289344
