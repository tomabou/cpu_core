    lui     s0, 7
    addi    s0, s0, 4092
    addi    s1, zero, -1
.LBB0_1:                              
    lw      t0, 4(zero)
    beq     t0, s1, .LBB0_1
    addi    t0, t0, -1

    fmv.w.x ft0, t0
    nop     4
    fmv.x.w t1, ft0

    sw      t1, 0(zero)
    sw      t1, 4(zero)
    j       .LBB0_1