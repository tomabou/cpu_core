#include "../header/nibuio.h"
#include "fdiv.c"

int main() {
    while (1) {
        float x = nibu_input() - '0';
        float y = nibu_input() - '0';
        float z = test__divsf3(x, y);
        // float z = x + y;
        print_int(z);
        print_string("\r\n");
    }
}