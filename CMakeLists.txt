cmake_minimum_required(VERSION 3.10)

project(CeloxOS)

set(CMAKE_ASM_NASM_OBJECT_FORMAT "elf32")
enable_language(ASM_NASM)

set(DISK_DIR ${CMAKE_SOURCE_DIR}/disk)
set(BIN_OUTPUT ${DISK_DIR}/boot/kernel)
set(BIN_DIR ${CMAKE_SOURCE_DIR}/bin)
set(ISO_OUTPUT ${BIN_DIR}/celox.iso)

set(CMAKE_C_FLAGS "-m32 -ffreestanding -nostdlib -I${CMAKE_SOURCE_DIR}/celox/include")

set(GRUB_MKRESCUE_BIN grub-mkrescue)
set(QEMU_BIN qemu-system-i386)

set(ASM_SRCFILES
    ${CMAKE_SOURCE_DIR}/celox/src/multiboot2.asm
    ${CMAKE_SOURCE_DIR}/celox/src/entry.asm
)

set(C_SRCFILES
    ${CMAKE_SOURCE_DIR}/celox/celox.c
    ${CMAKE_SOURCE_DIR}/celox/src/vga.c
)

add_executable(kernel
    ${ASM_SRCFILES}
    ${C_SRCFILES}
)

target_link_options(kernel PRIVATE 
    LINKER:-T${CMAKE_SOURCE_DIR}/linker.ld 
    LINKER:-melf_i386
)

file(MAKE_DIRECTORY ${BIN_DIR})
add_custom_command(TARGET kernel POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:kernel> ${BIN_OUTPUT}
    COMMENT "Copying kernel binary to disk/boot"
)

add_custom_command(TARGET kernel POST_BUILD
    COMMAND ${GRUB_MKRESCUE_BIN} -o ${ISO_OUTPUT} ${DISK_DIR}
    COMMENT "Creating a bootable image"
)

add_custom_target(run
    COMMAND ${QEMU_BIN} -cdrom ${ISO_OUTPUT}
    COMMENT "Running OS in QEMU"
)

# renamed to avoid conflict with cmake's "clean" target
add_custom_target(cleanall
    COMMAND ${CMAKE_COMMAND} -E rm -rf ${BIN_OUTPUT} ${ISO_OUTPUT}
    COMMENT "Cleaning build files"
)
