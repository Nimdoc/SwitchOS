print16:
	pusha			; Push registers to stack
	mov	ah, 0x0E	; Put print int code
loop_print16:
	mov	al, [bx]	; Put next char into al
	cmp	al, 0		; Check if it is null
	je end_print16		; Jump to end if char is null
	int	0x10		; Print character
	add	bx, 1		; Go to next character
	jmp loop_print16	; Loop
end_print16:
	popa			; Restore registers contents
	ret

print16_nl:
	pusha
	mov	ah, 0x0E	; BIOS print code
	mov	al, 0x0A	; Newline character
	int	0x10		; Print
	mov	al, 0x0D	; Carriage return character
	int	0x10		; Print
	popa
	ret
