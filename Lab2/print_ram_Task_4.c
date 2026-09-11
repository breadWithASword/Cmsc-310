#include <stdio.h>
extern unsigned char ram[];
extern void fill_ram(void);
int main() {
    fill_ram();
    printf("RAM contents of 50H: ");
    printf("%02X ", ram[0x50]);
    printf("\n");
    return 0;
}