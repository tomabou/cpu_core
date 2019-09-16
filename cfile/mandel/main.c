#include "../header/nibuio.h"

void init_ppm(int w, int h) {
    print_string("P2\r\n");
    print_int(35);
    nibu_output(' ');
    print_int(-40);
    print_string("\r\n");
    return;
}

int main() {
    init_ppm(256, 256);
    return 0;
}