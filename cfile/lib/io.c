int input();
void output(int);
void show(int);
void set_stackpointer();

/*
void test(){
    int x = input();
    int x2 = input();
    float y = (float)x;
    float y2 = x2;
    if (y > 96.0f){
        y = (y>y2) ? y :y2;
    }
    int z = (int)y;
    show(z);
    output(z);
    return ;
}
*/

int main() {
  int *pc = (int *)4096;
  while (1) {
    int code = 0;
    for (int i = 0; i < 4; i++) {
      int x = input();
      code += (x << (i * 8));
    }
    show(code);
    *pc = code;
    pc++;
    int status = input();
    if (status == 2)
      break;
  }
  set_stackpointer();
  void (*func)() = ((void (*)())4096);
  func();
  return 0;
}

void set_stackpointer() {
  asm volatile(".intel_syntax noprefix;\n\
        lui     sp, 7\n\
        addi    sp, sp, 4092");
  return;
}

int input_func(void) {
  int ret;
  asm volatile(".intel_syntax noprefix;\n\
        lw    %0, 4(zero);"
               : "=r"(ret));
  return ret;
}

int input() {
  int x = -1;
  while (x == -1) {
    x = input_func();
  }
  return x;
}

void output(int n) {
  asm volatile(".intel_syntax noprefix;\n\
        sw      %0, 4(zero);"
               :
               : "r"(n));
  return;
}

void show(int n) {
  asm volatile(".intel_syntax noprefix;\n\
        sw      %0, 0(zero);"
               :
               : "r"(n));
  return;
}