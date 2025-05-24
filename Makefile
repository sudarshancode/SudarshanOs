ISO_NAME = sudarshanos.iso
SRC_DIR = src
BUILD_DIR = build
ISO_DIR = iso
GRUB_DIR = grub

C_SOURCES = $(SRC_DIR)/kernel.c $(SRC_DIR)/screen/screen.c
OBJS = $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o $(BUILD_DIR)/screen.o $(BUILD_DIR)/port_io.o $(BUILD_DIR)/keyboard.o $(BUILD_DIR)/idt.o $(BUILD_DIR)/isr.o

all: $(ISO_NAME)

$(ISO_NAME): $(BUILD_DIR)/kernel.bin
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(BUILD_DIR)/kernel.bin $(ISO_DIR)/boot/kernel.bin
	cp $(GRUB_DIR)/grub.cfg $(ISO_DIR)/boot/grub/
	grub-mkrescue -o $(ISO_NAME) $(ISO_DIR)

# Compile C files
$(BUILD_DIR)/kernel.o: $(SRC_DIR)/kernel.c $(SRC_DIR)/include/screen.h
	mkdir -p $(BUILD_DIR)
	gcc -m32 -fno-stack-protector -fno-builtin -c $(SRC_DIR)/kernel.c -o $(BUILD_DIR)/kernel.o

$(BUILD_DIR)/screen.o: $(SRC_DIR)/screen/screen.c $(SRC_DIR)/include/screen.h
	gcc -m32 -fno-stack-protector -fno-builtin -c $(SRC_DIR)/screen/screen.c -o $(BUILD_DIR)/screen.o

$(BUILD_DIR)/port_io.o: $(SRC_DIR)/port_io.c $(SRC_DIR)/include/port_io.h
	gcc -m32 -fno-stack-protector -fno-builtin -c $(SRC_DIR)/port_io.c -o $(BUILD_DIR)/port_io.o

$(BUILD_DIR)/idt.o: $(SRC_DIR)/idt.c $(SRC_DIR)/include/idt.h
	gcc -m32 -fno-stack-protector -fno-builtin -c $(SRC_DIR)/idt.c -o $(BUILD_DIR)/idt.o

$(BUILD_DIR)/isr.o: $(SRC_DIR)/isr.c $(SRC_DIR)/include/isr.h
	gcc -m32 -fno-stack-protector -fno-builtin -c $(SRC_DIR)/isr.c -o $(BUILD_DIR)/isr.o
	
$(BUILD_DIR)/keyboard.o: $(SRC_DIR)/keyboard.c $(SRC_DIR)/include/keyboard.h
	gcc -m32 -fno-stack-protector -fno-builtin -c $(SRC_DIR)/keyboard.c -o $(BUILD_DIR)/keyboard.o
# Asm Compile
$(BUILD_DIR)/boot.o: $(SRC_DIR)/boot.s
	mkdir -p $(BUILD_DIR)
	nasm -f elf32 $(SRC_DIR)/boot.s -o $(BUILD_DIR)/boot.o

# Link object files into a binary
$(BUILD_DIR)/kernel.bin: $(OBJS) $(SRC_DIR)/linker.ld
	ld -m elf_i386 -T $(SRC_DIR)/linker.ld -o $(BUILD_DIR)/kernel.bin $(OBJS)

clean:
	rm -rf $(BUILD_DIR) $(ISO_DIR) $(ISO_NAME)
