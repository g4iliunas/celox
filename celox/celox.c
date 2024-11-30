#include <vga.h>
#include <types.h>

void __celox_main(void)
{
    for (int i = 0; i < VGA_MAX_ROWS * VGA_MAX_COLUMNS; i++)
        vga_putc('t');

    vga_putc('a');
    vga_putc('a');

    for (;;)
        ;
}
