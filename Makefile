CC = clang
CFLAGS = -m32 -ffreestanding -nostdlib

ASSEMBLER = nasm
ASMFLAGS = -felf32

LD = ld
LDFLAGS = -Tlinker.ld -melf_i386

GRUB_MKRESCUE = grub2-mkrescue

DISK_DIR = disk/
BIN_OUTPUT = $(DISK_DIR)boot/kernel.bin 
ISO_OUTPUT = celox/bin/celox.iso

BUILD_DIR = build/
SRCFILES := celox/src/entry.asm celox/src/celox.c
OBJFILES := $(patsubst celox/src/%.asm,$(BUILD_DIR)%.asm.o,$(patsubst celox/src/%.c,$(BUILD_DIR)%.c.o,$(SRCFILES)))

.PHONY: kernel
default: kernel
kernel: $(OBJFILES)
	@echo Linking...
	@$(LD) $(LDFLAGS) $^ -o $(BIN_OUTPUT)
	@echo Creating a bootable image...
	@$(GRUB_MKRESCUE) -o $(ISO_OUTPUT) $(DISK_DIR)

$(BUILD_DIR)%.c.o: celox/src/%.c
	@echo Building $@
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)%.asm.o: celox/src/%.asm
	@echo Building $@
	@$(ASSEMBLER) $(ASMFLAGS) $< -o $@

.PHONY: clean
clean: $(BUILD_DIR)
	@rm -rf $(BUILD_DIR)* $(BIN_OUTPUT) $(ISO_OUTPUT)