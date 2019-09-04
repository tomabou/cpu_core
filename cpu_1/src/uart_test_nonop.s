    addi    s1, zero, -1
.LBB0_1:                              
    lw      t0, 4(zero)
    beq     t0, s1, .LBB0_1
    addi    t0, t0, 1
    sw      t0, 0(zero)
    sw      t0, 4(zero)
    j       .LBB0_1