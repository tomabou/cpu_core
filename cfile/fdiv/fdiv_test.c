#include "fdiv.c"
#include <stdio.h>
#include <stdlib.h>

int main() {
    for (int i = 0; i < 100; i++) {
        int x = rand();
        int y = rand();
        x++;
        y++;
        float p = (float)x / 10000.0f;
        float q = (float)y / 10000.0f;

        float real = p / q;
        float act = test__divsf3(p, q);
        printf("%010.3f %010.3f %e\n", p, q, (act - real));
    }

    return 0;
}