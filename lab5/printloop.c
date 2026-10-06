#include <stdio.h>
extern unsigned char ram[];         // sets up the variable ram so it can be passed back by myloop.s
extern void _main(void);            // links the _main function of myloop.s to printloop.c
int main() {
    _main();                        // runs myloop.s, filling ram[0x50]
    printf("%02X\n", ram[0x50]);    // outputs the value of ram[0x50] in hexidecimal
    return 0;
}