#!/bin/bash

filepath="$1"
echo ${filepath%.*}
riscv32-unknown-linux-gnu-gcc -Wall -mstrict-align -mabi=ilp32f -march=rv32imf -mno-fdiv -mno-div -S -O2 $1 -o "${filepath%.*}.s"
python3 tools/asm.py "${filepath%.*}.s" loader
if [ $# -eq 1 ]; then
    cat "${filepath%.*}.bin" > /dev/ttyUSB0
fi