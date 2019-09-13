#include "../header/nibuio.h"

int fibo(int n) {
    if (n <= 1) {
        return 1;
    }
    return fibo(n - 1) + fibo(n - 2);
}

int main() {
    print_string("this is fibo");
    // while (1) {
    // int x = nibu_input();
    // nibu_show(x);
    //}
    return 0;
}