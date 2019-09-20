#include "../header/nibuio.h"

int main() {
    while (1) {
        int x = nibu_input();
        int y = nibu_input();
        int a = (x - '0') * (y - '0');
        nibu_show(a);
    }
    return 0;
}