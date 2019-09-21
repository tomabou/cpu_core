

__divsi3:
  bltz  a0, .L_divlib_10
  bltz  a1, .L_divlib_11
  ;/* Since the quotient is positive, fall into __udivsi3.  */

__udivsi3:
  mv    a2, a1
  mv    a1, a0
  li    a0, -1
  beqz  a2, .L_divlib_5
  li    a3, 1
  bgeu  a2, a1, .L_divlib_2
.L_divlib_1:
  blez  a2, .L_divlib_2
  slli  a2, a2, 1
  slli  a3, a3, 1
  bgtu  a1, a2, .L_divlib_1
.L_divlib_2:
  li    a0, 0
.L_divlib_3:
  bltu  a1, a2, .L_divlib_4
  sub   a1, a1, a2
  or    a0, a0, a3
.L_divlib_4:
  srli  a3, a3, 1
  srli  a2, a2, 1
  bnez  a3, .L_divlib_3
.L_divlib_5:
  ret
;FUNC_END (__udivsi3)

__umodsi3:
  ;/* Call __udivsi3(a0, a1), then return the remainder, which is in a1.  */
  move  t0, ra
  jal   __udivsi3
  move  a0, a1
  jr    t0
;FUNC_END (__umodsi3)

  /* Handle negative arguments to __divsi3.  */
.L_divlib_10:
  neg   a0, a0
  bgez  a1, .L_divlib_12      /* Compute __udivsi3(-a0, a1), then negate the result.  */
  neg   a1, a1
  j     __udivsi3     /* Compute __udivsi3(-a0, -a1).  */
.L_divlib_11:                 /* Compute __udivsi3(a0, -a1), then negate the result.  */
  neg   a1, a1
.L_divlib_12:
  move  t0, ra
  jal   __udivsi3
  neg   a0, a0
  jr    t0
;FUNC_END (__divsi3)

__modsi3:
  move   t0, ra
  bltz   a1, .L_divlib_31
  bltz   a0, .L_divlib_32
.L_divlib_30:
  jal    __udivsi3    /* The dividend is not negative.  */
  move   a0, a1
  jr     t0
.L_divlib_31:
  neg    a1, a1
  bgez   a0, .L_divlib_30
.L_divlib_32:
  neg    a0, a0
  jal    __udivsi3    /* The dividend is hella negative.  */
  neg    a0, a1
  jr     t0
;FUNC_END (__modsi3)
