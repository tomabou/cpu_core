;this is test for j

main:
    nop
    addi t3, zero ,0
    addi t0, zero, 3
    addi t1, zero, 1
    addi t2,zero, 2
    addi t4, zero, 13
    nop 3
loop:
    add t3, t0, t3
    nop 3
    sub t3, t3, t1
    nop 3 
    bge t3, t4, label1
    j loop
label1:
    nop
label2:
    j label2
    nop 10