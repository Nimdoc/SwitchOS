;
;	SWITCH-OS BOOT SECTOR
;
[bits 16]
[org 0x7C00]
KERNEL_OFFSET equ 0x1000	; The memory address where we load the Kernel

mov	[BOOT_DRIVE], dl	; Copy the boot drive the BIOS set for us

mov	bp, 0x9000	; Setup the stack
mov	sp, bp

mov	bx, MSG_REAL_MODE
call	print16
call	print16_nl

call	load_kernel

call 	switch_to_pm	; Note: Won't return from here.

jmp $		; Loop forever

load_kernel:
call 	print16_nl
mov	bx, MSG_LOAD_KRNL
call	print16
call 	print16_nl

mov	bx, KERNEL_OFFSET
mov	dh, 3
mov	dl, [BOOT_DRIVE]
call	disk_load16
ret

%include	"include/print16.asm"
%include	"include/disk16.asm"
%include	"include/print32.asm"
%include	"include/gdt.asm"
%include	"include/switch_pm.asm"

[bits 32]
BEGIN_PM:

mov	ebx, MSG_PROT_MODE
call	print32

call	KERNEL_OFFSET	; Call our loaded kernel

jmp	$		; Hang forever

; Variables
BOOT_DRIVE:	db 0

MSG_REAL_MODE:	db "SWITCH-OS 16 BIT REAL MODE", 0
MSG_PROT_MODE:	db "SWITCH-OS 32 BIT PROTECTED MODE", 0
MSG_LOAD_KRNL:	db "LOADING KERNEL...", 0

times 	510-($-$$) db 0
dw 	0xAA55
