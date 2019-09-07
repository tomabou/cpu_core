    addi    s1, zero, -1
.LBB0_1:                              
    lw      t0, 4(zero)
    beq     t0, s1, .LBB0_1
    addi    t0, t0, 1

    sw      t0, -12(s0)
    flw     ft0, -12(s0)
    nop     4
    fsw     ft0, -16(s0)
    lw      t1, -16(s0)

    sw      t1, 0(zero)
    sw      t1, 4(zero)
    j       .LBB0_1