#include "../header/nibuio.h"

void init_ppm(int w, int h) {
    print_string("P2\r\n");
    print_int(w);
    nibu_output(' ');
    print_int(h);
    print_string("\r\n");
    print_int(255);
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
        if (4 < nx * nx + ny * ny) {
            return i;
        }
        x = nx;
        y = ny;
    }
    return max_iter;
}

int main() {
    int X = 256;
    int Y = 256;
    init_ppm(X, Y);
    for (int i = 0; i < X; i++) {
        for (int j = 0; j < Y; j++) {
            // x -1.5 ~ 0.5
            // y -1 ~ 1
            float r = 2.0f * (float)i / X - 1.5f;
            float l = 2.0f * (float)j / Y - 1.0f;
            int a = mandel(r, l, 256);
            if (a == 256) {
                a = 0;
            }
            a *= 10;
            if (a > 255) {
                a = 255;
            }
            print_int(a);
            print_string(" ");
        }
        print_string("\r\n");
    }
    return 0;
}