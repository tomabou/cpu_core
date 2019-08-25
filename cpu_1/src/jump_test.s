;this is test for j

main:
    nop
    addi t0, zero, 3
    nop 3
loop:
    addi t0,t0 1
    nop 3
    j loop
    j label1
label1:
    nop
label2:
    j label2