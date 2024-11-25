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

# ANSI color codes
COL_BLUE = \033[1;34m
COL_GREEN = \033[1;32m
COL_YELLOW = \033[1;33m
COL_RED = \033[1;31m
COL_RESET = \033[0m

.PHONY: kernel
default: kernel
kernel: $(OBJFILES)
	@echo -e "$(COL_BLUE)Linking...$(COL_RESET)"
	@$(LD) $(LDFLAGS) $^ -o $(BIN_OUTPUT)
	@echo -e "$(COL_GREEN)Creating a bootable image...$(COL_RESET)"
	@$(GRUB_MKRESCUE) -o $(ISO_OUTPUT) $(DISK_DIR)

$(BUILD_DIR)%.c.o: celox/src/%.c
	@echo -e "$(COL_YELLOW)Building $@$(COL_RESET)"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)%.asm.o: celox/src/%.asm
	@echo -e "$(COL_YELLOW)Building $@$(COL_RESET)"
	@$(ASSEMBLER) $(ASMFLAGS) $< -o $@

.PHONY: clean
clean: $(BUILD_DIR)
	@echo -e "$(COL_RED)Cleaning...$(COL_RESET)"
	@rm -rf $(BUILD_DIR)* $(BIN_OUTPUT) $(ISO_OUTPUT)