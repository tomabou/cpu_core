    lui     s0, 7
    addi    s0, s0, 4092
    addi    s1, zero, -1
.LBB0_1:                              
    lw      t0, 4(zero)
    beq     t0, s1, .LBB0_1
    addi    t0, t0, -1

    fcvt.w.s    ft0, t0, rtz
    nop     4
    fmv.x.w t2, ft0
    sw      t2, 0(zero) 
    fmv.w.x ft1, t2
    nop     4
    fcvt.s.w    t1, ft1

    sw      t1, 4(zero)
    j       .LBB0_1