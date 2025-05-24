#pragma once
#include <stdint.h>

typedef struct{
    uint16_t offset_low;
    uint16_t selector;
    uint8_t zero;
    uint8_t type_attr;
    uint16_t offset_high;

} __attribute__((packed)) idt_entry_t;

typedef struct{
    uint16_t limit;
    uint32_t base;

}__attribute__((packed)) idt_ptr_t;

void set_idt_gate(int n,uint32_t handler); //For keyboard handler , we will send n=32
void load_idt();