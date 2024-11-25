ENTRY(__celox_entry)
OUTPUT_FORMAT(elf32-i386)
SECTIONS
{
    . = 1M;
    .boot : {*(.multiboot2_header)}
    .text : {*(.text)}
}