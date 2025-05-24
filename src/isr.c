#include "include/idt.h"
#include "include/port_io.h"

extern void keyboard_callback();  //C handler

__attribute__((naked)) void keyboard_isr() {
    __asm__ volatile (
        "pusha\n"
        "call keyboard_callback\n"
        "popa\n"
        "iret\n"
    );
}


void isr_install(){
    set_idt_gate(33,(uint32_t)keyboard_isr);

    //enable IRQ1 in PIC
    outb(0x21,0xFD);
    outb(0xA1,0xFF);
}