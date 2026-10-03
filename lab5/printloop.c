#include <stdio.h>
extern unsigned char ram[];
extern void _main(void);
int main() {
    _main();
    printf("%02X\n", ram[0x50]);
    return 0;
}