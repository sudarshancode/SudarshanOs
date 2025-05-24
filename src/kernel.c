//Header File
#include "include/screen.h"
#include "include/keyboard.h"
#include "include/idt.h"
#include "include/isr.h"
#include <stdint.h>

void pic_remap() {
    // ICW1 - begin initialization
    outb(0x20, 0x11);
    outb(0xA0, 0x11);

    // ICW2 - set vector offset
    outb(0x21, 0x20); // Master PIC: IRQ0-7 -> INT 32-39
    outb(0xA1, 0x28); // Slave PIC: IRQ8-15 -> INT 40-47

    // ICW3 - setup cascading
    outb(0x21, 0x04); // Master: has slave at IRQ2
    outb(0xA1, 0x02); // Slave: identity is 2

    // ICW4 - set mode
    outb(0x21, 0x01);
    outb(0xA1, 0x01);

    // Clear interrupt masks
    outb(0x21, 0x0);
    outb(0xA1, 0x0);
}


void kernel_main() {
    print("Welcome to SudarshanOS", 0);
    print("Keyboard Test O1", 1);
    print(">", 2);

    pic_remap();       
    load_idt();        
    isr_install();    
    
    while (1){
        __asm__ volatile("hlt");
    }
}

