[bits 32]
VIDEO_MEMORY	equ 0xB8000
WHT_ON_BLK	equ 0x0F

print:
	pusha
	mov	edx, VIDEO_MEMORY	; Set edx to start of video memory
	
loop_print:
	mov	al, [ebx]	; Move character to al
	mov	ah, WHT_ON_BLK	; Put attributes in ah
	
	cmp	al, 0
	je	end_print	

	mov	[edx], ax	; Move character to video memory

	add	ebx, 1		; Increment ebx to next character
	add	edx, 2		; Increment video memory to next cell

	jmp 	loop_print

end_print:
	popa
	ret
