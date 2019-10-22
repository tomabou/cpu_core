#include <stdbool.h>
//#include <stdio.h>
//#include <stdlib.h>
#include "../header/nibuio.h"

#define SIZE 1000
void main_func(int *source);
void loop_func(int **code_pptr, int **pptr);
bool switch_func(int **code_pptr, int **pptr);

int *global_start;

int sorce[SIZE];
int workspace[SIZE];

int main() {
    int *code_ptr = sorce;
    global_start = code_ptr;
    int c;
    while ((c = nibu_input()) != '@') {
        *code_ptr = c;
        nibu_output(c);
        code_ptr++;
    }
    print_string("start\r\n");
    main_func(global_start);
    return 0;
}

void main_func(int *source) {
    int *code_ptr = source;
    int *array = workspace;
    for (int i = 0; i < SIZE; i++) {
        array[i] = 0;
    }
    int *ptr = array;
    while (1) {
        print_string("first\r\n");
        int res = switch_func(&code_ptr, &ptr);
        print_string("test\r\n");
        print_int(res);
        if (res) break;
        code_ptr++;
    }
}

void loop_func(int **code_pptr, int **pptr) {
    int *start = *code_pptr;
    while (**pptr != 0) {
        (*code_pptr) = start + 1;
        while (1) {
            if (switch_func(code_pptr, pptr)) {
                break;
            }
            (*code_pptr)++;
        }
    }
    (*code_pptr) = start + 1;
    for (int count = 1; count > 0; (*code_pptr)++) {
        if (**code_pptr == ']') count--;
        if (**code_pptr == '[') count++;
    }
    (*code_pptr)--;
}

bool switch_func(int **code_pptr, int **pptr) {
    int token = **code_pptr;
    if (token == '\0') {
        return true;
    } else if (token == '>') {
        (*pptr)++;
    } else if (token == '<') {
        (*pptr)--;
    } else if (token == '+') {
        (**pptr)++;
    } else if (token == '-') {
        (**pptr)--;
    } else if (token == '.') {
        nibu_output(**pptr);
    } else if (token == ',') {
        **pptr = nibu_input();
    } else if (token == '[') {
        loop_func(code_pptr, pptr);
    } else if (token == ']') {
        return true;
    }
    return false;
}
