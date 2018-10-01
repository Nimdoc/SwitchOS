;
;	SWITCH-OS BOOT SECTOR
;
[bits 16]
[org 0x7C00]

mov	bp, 0x9000	; Setup the stack
mov	sp, bp

mov	bx,	REAL_MODE_MSG
call	print16
call	print16_nl

call switch_to_pm	; Note: Won't return from here.

jmp $		; Loop forever

%include	"include/print16.asm"
%include	"include/disk16.asm"
%include	"include/print32.asm"
%include	"include/gdt.asm"
%include	"include/switch_pm.asm"

BEGIN_PM:

mov	ebx, PROT_MODE_MSG
call	print32

jmp	$

; Variables
BOOT_DRIVE:	db 0

REAL_MODE_MSG:	db "SWITCH-OS 16 BIT REAL MODE", 0
PROT_MODE_MSG:	db "SWITCH-OS 32 BIT PROTECTED MODE", 0

times 	510-($-$$) db 0
dw 	0xAA55

