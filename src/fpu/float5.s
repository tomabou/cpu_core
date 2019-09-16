main:
    lui     s0, 8
    addi    s0, s0, -4
    addi    s1, zero, -1
.LBB0_1:                              
    lw      t0, 4(zero)
    beq     t0, s1, .LBB0_1
    addi    t1, zero, 3

    fcvt.w.s    ft1, t0, rtz
    fcvt.w.s    ft2, t1,rtz
    fmul.s  ft5, ft1, ft2 
    fcvt.s.w    t2, ft5
    sw      t0, 4(zero)
    sw      t2, 0(zero)
    j       .LBB0_1