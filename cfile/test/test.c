#include "../header/nibuio.h"

int main() {
    int x = nibu_input();
    int y = nibu_input();
    int z = x - y;
    if (z < 0) {
        nibu_show(5);
    } else {
        nibu_show(7);
    }
    return 0;
}