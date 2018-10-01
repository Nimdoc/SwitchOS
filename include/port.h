#ifndef	PORT_H
#define	PORT_H

void port_write_byte(unsigned short port, unsigned char data);
unsigned char port_read_byte(unsigned short port);

void port_write_word(unsigned short port, unsigned short data);
unsigned short port_read_word(unsigned short port);

#endif
