#include <stdio.h>
#include "pi.c"

int main()
{
    float pi = leibniz(10000);
    printf("%f\n", pi);
    return 0;
}