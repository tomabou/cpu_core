main:
        lui     a0, 1
        addi    a1, zero, -1
        addi    a2, zero, 2
.LBB0_1:                                # =>This Loop Header: Depth=1
        lw    a3, 4(zero);
        beq     a3, a1, .LBB0_1
.LBB0_2:                                #   Parent Loop BB0_1 Depth=1
        lw    a4, 4(zero);
        beq     a4, a1, .LBB0_2
        slli    a4, a4, 8
        add     a3, a3, a4
.LBB0_4:                                #   Parent Loop BB0_1 Depth=1
        lw    a4, 4(zero);
        beq     a4, a1, .LBB0_4
        slli    a4, a4, 16
        add     a3, a3, a4
.LBB0_6:                                #   Parent Loop BB0_1 Depth=1
        lw    a4, 4(zero);
        beq     a4, a1, .LBB0_6
        slli    a4, a4, 24
        add     a3, a3, a4
        sw      a4, 0(zero);
        sw      a3, 0(a0)
        addi    a0, a0, 4
.LBB0_8:                                #   Parent Loop BB0_1 Depth=1
        lw    a3, 4(zero);
        beq     a3, a1, .LBB0_8
        bne     a3, a2, .LBB0_1
        lui     sp, 8
        addi    sp, sp, -4
        lui     s0, 8
        addi    s0, s0, -4
        lui     a0, 1
        jalr    a0