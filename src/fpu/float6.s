main:
    addi    s1, zero, -1
.LBB0_1:                              
    lw      t0, 4(zero)
    beq     t0, s1, .LBB0_1
    addi    t1, zero, 96 

    fcvt.w.s    ft1, t0, rtz
    fcvt.w.s    ft2, t1,rtz
    flt.s       t3, ft1, ft2
    add    t2, t0, t3
    sw      t2, 4(zero)
    j       .LBB0_1