#include <vga.h>

#include <types.h>

static volatile u16 *vga_buf = (u16 *)VGA_TEXT_ADDRESS;
static u32 cursor_x = 0;
static u32 cursor_y = 0;

void vga_putc(char ch)
{
    if (ch == '\n' || cursor_x >= VGA_MAX_ROWS) {
        cursor_x = 0;
        cursor_y++;
    }

    if (cursor_y >= VGA_MAX_COLUMNS) {
        // todo: make it scroll by swapping vga buf memory?
        cursor_x = 0;
        cursor_y = 0;
    }

    u32 index = cursor_y * VGA_MAX_ROWS + cursor_x;
    vga_buf[index] = ch | (VGA_COLOR_WHITE << 8);
    cursor_x++;
}