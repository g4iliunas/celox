section .multiboot2_header
multiboot2_header_start:
dd 0xE85250D6 ; magic
dd 0 ; 32bit protected mode of i386
dd multiboot2_header_end - multiboot2_header_start ; header length
dd -(0xE85250D6 + 0 + multiboot2_header_end - multiboot2_header_start) ; checksum
dw 0 ; type
dw 0 ; flags
dd 8 ; size
multiboot2_header_end: