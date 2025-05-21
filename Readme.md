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
