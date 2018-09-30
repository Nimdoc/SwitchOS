[bits 16]

switch_to_pm:
	cli		; Clear all interupts

	lgdt	[gdt_descriptor]	; Load the globak descriptor table

	mov	eax, cr0	; Set the first bit in the control
	or	eax, 0x1	; register to 1 to switch to pm
	mov	cr0, eax

	jmp	CODE_SEG:init_pm

[bits 32]

init_pm:
	mov	ax, DATA_SEG	; Point the segment registers to the 
	mov	ds, ax		; Data selector we define in the GDT
	mov	ss, ax		; The old ones are useless
	mov	es, ax
	mov	fs, ax
	mov	gs, ax

	mov	ebp, 0x90000	; Update base pointer and stack pointer
	mov	esp, ebp	; to the top of available memory

	call BEGIN_PM
