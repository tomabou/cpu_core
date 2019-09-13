int input();
void output(int);
void show(int);

int main()
{
    int *pc = (int *)4096;
    while (1)
    {
        int code = 0;
        int x = -1;
        for (int i = 0; i < 4; i++)
        {
            x = -1;
            while (x == -1)
            {
                x = input();
            }
            code += (x << (i * 8));
        }
        show(code);
        *pc = code;
        pc++;
        int status = -1;
        while (status == -1)
        {
            status = input();
        }
        if (status == 2)
            break;
    }
    void (*func)() = ((void (*)())4096);
    func();
    return 0;
}

int input(void)
{
    int ret;
    asm volatile(
        ".intel_syntax noprefix;\n\
        lw    %0, 4(zero);\n\
        nop;\n\
        nop;\n\
        nop;\n\
        nop;"
        : "=r"(ret));
    return ret;
}

void show(int n)
{
    asm volatile(
        ".intel_syntax noprefix;\n\
        sw      %0, 0(zero);"
        : "=r"(n));
    return;