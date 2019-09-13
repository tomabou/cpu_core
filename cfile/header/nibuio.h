#ifndef NIBUIO_H
#define NIBUIO_H

#ifndef DEBUG_MODE

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

#else
#include <stdio.h>
#include <stdlib.h>
int nibu_input() {
    int res = system("/bin/stty raw");
    if (res != 0) {
        exit(1);
    }
    int c = getchar();
    res = system("/bin/stty cooked");
    if (res != 0) {
        exit(1);
    }
    if (c == 3) {
        exit(1);  // finish with ctrl-C
    }
    return c;
}

void nibu_output(int n) {
    char x = n & (0x000000FF);
    putchar(x);
    return;
}

void nibu_show(int n) {
    unsigned int show = n & (0x0000FFFF);
    printf("\x1b[7m%x\x1b[0m", show);
    return;
}

#endif

void print_string(char* c) {
    while (*c != '\0') {
        nibu_output(*c);
        c++;
    }
    return;
}

#endif
