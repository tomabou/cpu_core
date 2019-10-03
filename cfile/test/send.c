#include "../header/nibuio.h"

int main() {
    for (int i = 0; i < 100; i++) {
        for (int j = 0; j < 26; j++) {
            nibu_output(j + 'a');
            nibu_output(j + 'A');
        }
        print_int(i);
        print_string("\r\n");
    }
    return 0;
}