#include "../header/nibuio.h"

int main() {
    while (1) {
        int x = nibu_input();
        int y = nibu_input();
        int z = nibu_input();
        int w = nibu_input();
        int a = 5 + ((x - y) < (z - w));
        nibu_show(a);
    }
    return 0;
}