#include "include/port_io.h"
#include "include/screen.h"

void keyboard_handler() {
    unsigned char scancode = inb(0x60);
    
    char str[3];
    str[0] = "0123456789ABCDEF"[scancode >> 4];
    str[1] = "0123456789ABCDEF"[scancode & 0xF];
    str[2] = 0;
    print(str, 1);
}
