main:
    lui     s0, 8
    addi    s0, s0, -4
    addi    s1, zero, -1
    addi    t1, zero, 1
    fcvt.w.s    ft1, zero, rtz
    fcvt.w.s    ft2, t1,rtz
    fadd.s  ft5, ft1, ft2 
    fadd.s  ft5, ft5, ft2 
    fadd.s  ft5, ft5, ft2 
    fadd.s  ft5, ft5, ft2 
    fadd.s  ft5, ft5, ft2 
    fadd.s  ft5, ft5, ft2 
    fadd.s  ft5, ft5, ft2 
    fadd.s  ft5, ft5, ft2 
    fcvt.s.w    t2, ft5

    addi    t2, t2, 16
    sw      t2, 0(zero)
.LBB0_1
    j       .LBB0_1