main:
	lw    a1, 4(zero);
	lw    a2, 4(zero);
	ble	a1,a2,.L47
    addi  a1, a1, 1
.L47:
    sw    a1, 4(zero)
	j	main