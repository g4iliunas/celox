ENTRY(__celox_entry)
OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 1M;
    .text : {*(.text)}
}