#include "../header/nibuio.h"

int main() {
    for (int i = 0; i < (1 << 5); i++) {
        nibu_output(i);
    }
    for (int i = 0; i < (1 << 5); i++) {
        int a = nibu_input_func();
        nibu_show(a);
    }

    return 0;
}