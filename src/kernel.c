// Multiboot header
__attribute__((section(".multiboot")))
const unsigned int multiboot_header[] = {
    0x1BADB002,       // magic
    0x00000000,       // flags
    0xE4524FFE        // checksum (-(magic + flags))
};

//Header File
#include "include/screen.h"
#include "include/keyboard.h"
void kernel_main() {
    
    print("Welcome to Kernel",0); // print(String,line_number)
    keyboard_handler(); //Take character from keyboard


    while (1);// __asm__ volatile("hlt");
}

