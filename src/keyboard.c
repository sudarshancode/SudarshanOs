#include "include/port_io.h"
#include "include/screen.h"
#include <stdint.h>

static char scancode_to_ascii(unsigned char scancode) {
    static char map[128] = {
        0, 27, '1','2','3','4','5','6','7','8','9','0','-','=','\b',
        '\t',
        'q','w','e','r','t','y','u','i','o','p','[',']','\n',
        0,
        'a','s','d','f','g','h','j','k','l',';','\'','`',
        0,
        '\\','z','x','c','v','b','n','m',',','.','/',0,
        '*',
        0,
        ' ',
        0,
        // rest 0
    };
    if (scancode > 127) return 0;
    return map[scancode];
}

// Simple line tracker for cursor
static int current_line = 2;

void keyboard_callback(){
    uint8_t scancode = inb(0x60);
    char ascii = scancode_to_ascii(scancode);

    if (ascii) {
        char str[2] = { ascii, 0 };
        print(str, current_line);
        current_line++;
    }

    // Send EOI (End of Interrupt) to PIC
    outb(0x20, 0x20);
}
