ISO_NAME = sudarshanos.iso
SRC_DIR = src
BUILD_DIR = build
ISO_DIR = iso
GRUB_DIR = grub

all: $(ISO_NAME)

$(ISO_NAME): $(BUILD_DIR)/kernel.bin
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(BUILD_DIR)/kernel.bin $(ISO_DIR)/boot/kernel.bin
	cp $(GRUB_DIR)/grub.cfg $(ISO_DIR)/boot/grub/
	grub-mkrescue -o $(ISO_NAME) $(ISO_DIR)

$(BUILD_DIR)/kernel.bin: $(SRC_DIR)/kernel.c $(SRC_DIR)/linker.ld
	mkdir -p $(BUILD_DIR)
	gcc -m32 -ffreestanding -c $(SRC_DIR)/kernel.c -o $(BUILD_DIR)/kernel.o
	ld -m elf_i386 -T $(SRC_DIR)/linker.ld -o $(BUILD_DIR)/kernel.bin $(BUILD_DIR)/kernel.o

clean:
	rm -rf $(BUILD_DIR) $(ISO_DIR) $(ISO_NAME)

