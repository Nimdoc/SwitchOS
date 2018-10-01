#ifndef SCREEN_H
#define SCREEN_H

#define VIDEO_ADDRESS	0xB8000
#define MAX_ROWS	25
#define MAX_COLS	80

#define WHITE_ON_BLACK	0x0F

#define REG_SCRN_CTRL	0x3D4
#define REG_SCRN_DATA	0x3D5

void print_char(char character, int col, int row, char attr);
void print_at(char* message, int col, int row);
void print(char* message);

int get_cursor();
void set_cursor(int offset);

void clear_screen();

#endif
