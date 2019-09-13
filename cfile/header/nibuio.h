#ifndef NIBUIO_H
#define NIBUIO_H

int nibu_input_func(void) {
    int ret;
    asm volatile("lw    %0, 4(zero);" : "=r"(ret));
    return ret;
}

int nibu_input() {
    int x = -1;
    while (x == -1) {
        x = nibu_input_func();
    }
    return x;
}

void nibu_output(int n) {
    asm volatile("sw      %0, 4(zero);" : : "r"(n));
    return;
}

void nibu_show(int n) {
    asm volatile("sw      %0, 0(zero);" : : "r"(n));
    return;
}

#endif
