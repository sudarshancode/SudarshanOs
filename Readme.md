# Sudarshan Os Kernel

# 🔧 Simple 32-bit Kernel (Protected Mode, GRUB Multiboot)

## Required Tools

```bash
    sudo apt update
    sudo apt install gcc xorriso grub-pc-bin mtools
    sudo apt install qemu-system
```

## Build the iso

```bash
    make
    qemu-system-x86_64 -cdrom sudarshanos.iso
```

## Keyboard Inerrupt Handling Follow
```bash
    ┌────────────────────────────┐
    │       Keyboard Hardware     │
    │  (User presses a key)       │
    └───────────────┬────────────┘
                    │
                    │ IRQ1 Interrupt Signal
                    ↓
    ┌────────────────────────────┐
    │      PIC (Programmable      │
    │    Interrupt Controller)    │
    │ (Remapped IRQ1 to IDT #33) │
    └───────────────┬────────────┘
                    │
                    │ Interrupt Request
                    ↓
    ┌────────────────────────────┐
    │          CPU                │
    │   (Interrupt Processing)   │
    │                            │
    │  - CPU stops current task  │
    │  - Looks up IDT entry #33  │
    │  - Jumps to irq1 handler   │
    └───────────────┬────────────┘
                    │
                    ↓
    ┌────────────────────────────┐
    │      irq1 Assembly Stub     │
    │                            │
    │  - Registers সংরক্ষণ করে  │
    │  - কল করে keyboard_handler│
    │  - PIC কে EOI পাঠায়        │
    │  - রেজিস্টার রিস্টোর করে    │
    │  - CPU পূর্বের কাজ চালায়    │
    └───────────────┬────────────┘
                    │
                    ↓
    ┌────────────────────────────┐
    │    keyboard_handler (C)    │
    │                            │
    │  - inb(0x60) take scancode │
    │  - scancode_to_ascii convert|
    │       to ASCII code        |
    │  - print_char write on screen │
    └────────────────────────────┘

```