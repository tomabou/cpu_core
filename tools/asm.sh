#!/bin/bash

filepath="$1"
echo ${filepath%.*}
python3 tools/asm.py $1 loader
if [ $# -eq 1 ]; then
    cat "${filepath%.*}.bin" > /dev/ttyUSB0
fi