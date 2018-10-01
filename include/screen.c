#include "screen.h"
#include "port.h"

// Some private functions
int get_offset(int col, int row);
int get_offset_row(int offset);
int get_offset_col(int offset);

void print_char(char character, int col, int row, char attr)
{
	unsigned char* vid_mem = (unsigned char *)VIDEO_ADDRESS;
	int offset;

	if(!attr)
		attr = WHITE_ON_BLACK;

	if(col >= MAX_COLS)
	{
		col = 0;
		row++;
	}
	if(row >= MAX_ROWS)
	{
		row = row % MAX_ROWS;
	}


	if((col >= 0) && (row >= 0))
		offset = get_offset(col, row);
	else
	{
		offset = get_cursor();
		row = get_offset_row(offset); 
		col = get_offset_col(offset); 
	}

	if(character == '\n')
	{
		row = (row + 1) % MAX_ROWS;
		col = 0;

		offset = get_offset(col, row);
	}
	else
	{
		vid_mem[offset] = character;
		vid_mem[offset+1] = attr;
	}

	set_cursor(offset);
}

void print_at(char* message, int col, int row)
{
	int offset;

	if((col >= 0) && (row >= 0))
	{
		col = col % MAX_COLS;
		row = row % MAX_ROWS;	
		offset = get_offset(col, row);
		set_cursor(offset);
	}
	else
	{
		offset = get_cursor();
		row = get_offset_row(offset);
		col = get_offset_col(offset);
	}
	
	int i = 0;
	while(message[i] != 0)
	{
		print_char(message[i], col + i, row, WHITE_ON_BLACK);
		i++;
	}
}

void print(char* message)
{
	print_at(message, -1, -1);
}

/*
Get the cursors position on the screen
*/
int get_cursor()
{
	int offset;

	// 14 is the high bit of the screens control register
	// 15 is the low bit of the screens register
	// Write to get the data and read it
	port_write_byte(REG_SCRN_CTRL, 14);
	offset = port_read_byte(REG_SCRN_DATA) << 8;
	port_write_byte(REG_SCRN_CTRL, 15);
	offset += port_read_byte(REG_SCRN_DATA);

	return offset * 2;
}

/*
Set the position of the cursor on screen
*/
void set_cursor(int offset)
{
	offset /= 2;

	// 14 is the high bit of the screens control register
	// 15 is the low bit of the screens register
	// Write to get the data and read it
	port_write_byte(REG_SCRN_CTRL, 14);
	port_write_byte(REG_SCRN_DATA, (unsigned char)(offset >> 8));
	port_write_byte(REG_SCRN_CTRL, 15);
	port_write_byte(REG_SCRN_DATA, (unsigned char)(offset & 0xFF));
}

void clear_screen()
{
	int screen_size = MAX_COLS * MAX_ROWS;

	char* screen = (char*)VIDEO_ADDRESS;

	for(int i = 0; i < screen_size; i++)
	{
		screen[i*2] = ' ';
		screen[i*2+1] = WHITE_ON_BLACK;
	}

	set_cursor(get_offset(0, 0));
}

int get_offset(int col, int row) { return 2 * (row * MAX_COLS + col); }
int get_offset_row(int offset) { return offset / (2 * MAX_COLS); }
int get_offset_col(int offset) { return (offset - (get_offset_row(offset)*2*MAX_COLS))/2; }
