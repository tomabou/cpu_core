
main:
    nop
    addi sp, zero, 8
    addi t0, zero, 3
    sw t0, 4(sp)
    nop 3
loop:
    lw t0, 4(sp)
    nop 4
    addi t0, t0, 1 
    addi sp, sp, 4
    nop 3
    sw t0, 4(sp)
    nop 3
    j loop
    nop 10