#!/bin/bash

filepath="$1"
gcc -Wall -O2 -DDEBUG_MODE $1 -o "${filepath%.*}.out"
"${filepath%.*}.out"