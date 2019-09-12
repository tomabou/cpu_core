main:
    lui     sp, 8
    addi    sp, sp, -20
    addi    t1, zero, 15
    sw      t1, 4(sp)
    lw      t2, 4(sp)
    addi    t3, t2, 17
    sw      t3, 0(zero)
end:   
    j       end