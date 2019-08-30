main:
    addi sp, zero,1024
    nop 4
    call func2
end:
    j end
func1:
    sw      ra, 0(zero)
    ret
func2:
    sw      ra, 4(sp)
    nop 3
    call func1
    lw ra, 4(sp)
    nop 3
    ret