#include "../header/nibuio.h"

int fibo(int n) {
    if (n <= 1) {
        return 1;
    }
    return fibo(n - 1) + fibo(n - 2);
}

int main() {
    nibu_show(fibo(5));
    return 0;
};