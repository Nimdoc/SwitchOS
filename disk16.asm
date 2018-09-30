; load DH sectors to ES : BX from drive DL
disk_load16:
	push 	dx		; Push DX onto stack so we can use it later
	mov	ah, 0x02	; Bios read disk code
	mov	al, dh		; Read dh sectors
	mov	ch, 0x00	; Select cylinder 0
	mov	dh, 0x00	; Select head 0
	mov 	cl, 0x02	; Read second sector(after boot sector)

	int 	0x13		; Read disk interupt

	jc	disk_error	; Jump if carry flag is set

	pop 	dx		; Restore dx
	cmp	dh, al		; Compar sectors read to sectors expected
	jne	disk_error	
	ret

disk_error:
	mov	bx, DISK_ERROR_MSG
	call	print16
	jmp	$

; Variables
DISK_ERROR_MSG	db 	"Disk read error :/", 0
	
