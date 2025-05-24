//Header File
#include "include/screen.h"
#include "include/keyboard.h"
#include "include/idt.h"
#include "include/isr.h"
#include <stdint.h>

void kernel_main() {
    print("Keyboard Test O1", 0);

    load_idt();     // Load IDT
    isr_install();  // Setup keyboard ISR
    __asm__ volatile("sti");  // Enable interrupts
    while (1);// __asm__ volatile("hlt");
}

