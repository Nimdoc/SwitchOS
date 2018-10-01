#include "port.h"

/*

C wrapper function that takes a byte and writes it to a
specified port

*/
void port_write_byte(unsigned short port, unsigned char data)
{
	__asm__("out %%al, %%dx" : :"a" (data), "d" (port));
}

/*

C wrapper function that reads a byte from a specified port
and returns it

*/
unsigned char port_read_byte(unsigned short port)
{
	unsigned char result;
	__asm__("in %%dx, %%al" : "=a" (result), "d" (port));
	return result;
}

/*

C wrapper function that takes a byte and writes it to a
specified port

*/
void port_write_word(unsigned short port, unsigned short data)
{
	__asm__("out %%ax, %%dx" : :"a" (data), "d" (port));
}

/*

C wrapper function that reads a byte from a specified port
and returns it

*/
unsigned short port_read_word(unsigned short port)
{
	unsigned short result;
	__asm__("in %%dx, %%ax" : "=a" (result), "d" (port));
	return result;
}

