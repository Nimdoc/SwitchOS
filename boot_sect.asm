;
;	SWITCH-OS BOOT SECTOR
;
[bits 16]
[org 0x7C00]

mov	[BOOT_DRIVE], dl	; Put bootdrive into variable

mov 	bp, 0x8000		; Set the base pointer out of the way
mov	sp, bp			; Move stack pointer to base pointer

mov	bx, 0x9000		; Load 5 sectors to 0x0000(ES):0x9000(BX)
mov	dh, 1			; from the boot drive
mov 	dl, [BOOT_DRIVE]
call disk_load16

mov	bx, 0x9000		; Print whatever is at that address
call	print16
call	print16_nl

loop:			; Forever do an infinite loop
	jmp loop

%include	"print16.asm"
%include	"disk16.asm"

; Variables
BOOT_DRIVE:	db 0

times 	510-($-$$) db 0
dw 	0xAA55

message:	db "Hello buddy.", 0
times 500 db 0

times 14*256 dw 0xdada
