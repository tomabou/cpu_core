#include "../header/nibuio.h"

int fibo(int n) {
    if (n <= 1) {
        return 1;
    }
    return fibo(n - 1) + fibo(n - 2);
}

int main() {
    while (1) {
        int x = nibu_input();
        if ((x < (int)'0') | (x > (int)'9')) {
            print_string("input number!\r\n");
        } else {
            int y = fibo((x - (int)'0'));
            print_string("answer is ");
            nibu_show(y);
            print_int(y);
            print_string(" \r\n");
        }
    }
    return 0;
}