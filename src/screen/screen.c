#include "../include/screen.h"

#define VGA_WIDTH 80

void print(const char *str,int line) {
    char *vga = (char *)0xb8000;
    /*
        VGA text mode memory starts at address 0xB8000.
        Each character on screen uses 2 bytes:
            1 byte = ASCII character.
            1 byte = Color/attribute.
        The screen has 80 columns × 25 rows = 2000 characters max.
        So, a full line of text uses: 80 × 2 = 160 bytes.
    */
    int offset=line * VGA_WIDTH * 2; 
    int i = 0;
    while (str[i]) {
        vga[offset+ i * 2] = str[i];
        vga[offset + i * 2 + 1] = 0x02;  // Light green text
        i++;
    }
}
