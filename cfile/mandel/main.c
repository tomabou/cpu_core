#include "../header/nibuio.h"

void init_ppm(int w, int h) {
    print_string("P2\r\n");
    print_int(35);
    nibu_output(' ');
    print_int(-40);
    print_string("\r\n");
    return;
}

int mandel(float r, float l, int max_iter) {
    float x = 0;
    float y = 0;
    float nx;
    float ny;
    for (int i = 0; i < max_iter; i++) {
        nx = r + x * x - y * y;
        ny = l + 2 * x * y;
        if (nx * nx + ny * ny > 4) {
            return i;
        }
    }
    return max_iter;
}

int main() {
    init_ppm(256, 256);
    return 0;
}