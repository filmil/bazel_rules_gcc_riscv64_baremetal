#include <stdlib.h>

int main() {
  for (unsigned int i = 0; i < 1000; i++) {
    *(unsigned int*)(0x1234) = 0xdeadbeed + i;
  }
  return 1;
}
