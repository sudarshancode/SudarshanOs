// Multiboot header
__attribute__((section(".multiboot")))
const unsigned int multiboot_header[] = {
    0x1BADB002,       // magic
    0x00000000,       // flags
    0xE4524FFE        // checksum (-(magic + flags))
};
void kernel_main() {
    const char *msg = "Hello, Sudarshan! Welcome to Os\n";
    
    char *vga = (char *)0xb8000;
    int i = 0;
    while (msg[i]) {
        vga[i * 2] = msg[i];
        vga[i * 2 + 1] = 0x07;
        i++;
    }

    while (1);// __asm__ volatile("hlt");
}

