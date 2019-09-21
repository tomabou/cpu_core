#include "../header/nibuio.h"

union a {
    int i;
    float f;
};

int main() {
    while (1) {
        float x = nibu_input() - '0';
        float y = nibu_input() - '0';
        print_int(x * y);
        print_string("\r\n");
    }
    return 0;
}