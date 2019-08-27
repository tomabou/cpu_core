main:                                   # @main
        addi    sp, zero, 1024
        addi    a0, zero, 6
        nop 3
        call    fibo(int)
end:
        j       end
fibo(int):                               # @fibo(int)
        addi    sp, sp, -16
        sw      a0, 0(zero)
        nop 2
        sw      ra, 12(sp)
        sw      s1, 8(sp)
        sw      s2, 4(sp)
        addi    t1, zero, 1
        nop 3
        blt     t1, a0, .LBB1_2
        addi    a0, zero, 1
        j       .LBB1_3
.LBB1_2:
        addi    s1, a0, 0
        addi    a0, a0, -1
        nop 3
        call    fibo(int)
        addi    s2, a0, 0
        addi    a0, s1, -2
        nop 3
        call    fibo(int)
        add     a0, a0, s2
.LBB1_3:
        lw      ra, 12(sp)
        lw      s1, 8(sp)
        lw      s2, 4(sp)
        addi    sp, sp, 16
        sw      a0, 0(zero)
        nop 2
        ret