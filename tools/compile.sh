#!/bin/bash

filepath="$1"
echo ${filepath%.*}
riscv32-unknown-linux-gnu-gcc -mabi=ilp32f -march=rv32imf -mno-fdiv -O2 -S $1 -o "${filepath%.*}.s"