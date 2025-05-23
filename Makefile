ISO_NAME = sudarshanos.iso
SRC_DIR = src
BUILD_DIR = build
ISO_DIR = iso
GRUB_DIR = grub

C_SOURCES = $(SRC_DIR)/kernel.c $(SRC_DIR)/screen/screen.c
OBJS = $(BUILD_DIR)/kernel.o $(BUILD_DIR)/screen.o $(BUILD_DIR)/port_io.o $(BUILD_DIR)/keyboard.o

all: $(ISO_NAME)

$(ISO_NAME): $(BUILD_DIR)/kernel.bin
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(BUILD_DIR)/kernel.bin $(ISO_DIR)/boot/kernel.bin
	cp $(GRUB_DIR)/grub.cfg $(ISO_DIR)/boot/grub/
	grub-mkrescue -o $(ISO_NAME) $(ISO_DIR)

# Compile C files
$(BUILD_DIR)/kernel.o: $(SRC_DIR)/kernel.c $(SRC_DIR)/include/screen.h
	mkdir -p $(BUILD_DIR)
	gcc -m32 -ffreestanding -c $(SRC_DIR)/kernel.c -o $(BUILD_DIR)/kernel.o

$(BUILD_DIR)/screen.o: $(SRC_DIR)/screen/screen.c $(SRC_DIR)/include/screen.h
	gcc -m32 -ffreestanding -c $(SRC_DIR)/screen/screen.c -o $(BUILD_DIR)/screen.o

$(BUILD_DIR)/port_io.o: $(SRC_DIR)/port_io.c $(SRC_DIR)/include/port_io.h
	gcc -m32 -ffreestanding -c $(SRC_DIR)/port_io.c -o $(BUILD_DIR)/port_io.o

$(BUILD_DIR)/keyboard.o: $(SRC_DIR)/keyboard.c $(SRC_DIR)/include/keyboard.h
	gcc -m32 -ffreestanding -c $(SRC_DIR)/keyboard.c -o $(BUILD_DIR)/keyboard.o

# Link object files into a binary
$(BUILD_DIR)/kernel.bin: $(OBJS) $(SRC_DIR)/linker.ld
	ld -m elf_i386 -T $(SRC_DIR)/linker.ld -o $(BUILD_DIR)/kernel.bin $(OBJS)

clean:
	rm -rf $(BUILD_DIR) $(ISO_DIR) $(ISO_NAME)
