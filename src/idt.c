#include "include/idt.h"
#include "include/port_io.h"

#define IDT_ENTRIES 256
idt_entry_t idt[IDT_ENTRIES];
idt_ptr_t idtp;

void set_idt_gate(int n,uint32_t handler){
    idt[n].offset_low=handler & 0xFFFF;
    idt[n].selector=0x08;
    idt[n].zero=0;
    idt[n].type_attr=0x8E;
    idt[n].offset_high=(handler >> 16) & 0xFFFF;
}

void load_idt(){
    idtp.limit=sizeof(idt_entry_t) * IDT_ENTRIES -1;
    idtp.base=(uint32_t)&idt;
    __asm__ volatile("lidtl (%0)" :: "r"(&idtp));
}