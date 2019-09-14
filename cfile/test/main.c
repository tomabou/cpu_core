#include "../header/nibuio.h"

int main() {
    while (1) {
        int x = nibu_input();
        nibu_output(x);
    }
    return 0;
}
