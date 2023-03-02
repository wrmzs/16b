[org 0x9000]

FILE_TABLE equ 0x8e00
PROGRAM equ 0x9400

jmp start

; SUBROTINES VECTOR
jmp shell.loop
jmp putstr
jmp setvideo
jmp load_file
jmp readstr
jmp readchar
jmp putchar
jmp run_program
jmp cmpstr
jmp draw_pixel

;SYSCALLS
%include "include/video.asm"
%include "include/keyboard.asm"
%include "include/mem.asm"
%include "include/fs.asm"

;KERNEL SUBROTINES

;sector in cl
;drive in dl
;buffer in es:bx
loadsector:
	pusha

	mov ah, 0x02
	mov al, 1
	xor ch, ch
	xor dh, dh

	mov dl, [BOOT_DEV]
	
	int 13h

	jc error

	popa
	ret

error:
	hlt


load_table:
	pusha
	
	mov cl, 2
	xor ax, ax
	mov es, ax
	mov bx, FILE_TABLE
	mov dl, [BOOT_DEV]
	call loadsector

	popa
	ret
	

shell:
	mov si, shell_msg
	call putstr
	
	.loop:
		mov si, prompt
		call putstr

		mov ch, 20
		mov di, buff
		call fill

		mov ah, 20
		mov di, buff
		call readstr

		mov si, buff
		
		call run_program		
		cmp cl, 0		
		je .error		

		jmp .loop

	.error:
		mov si, errorstr
		call putstr
		jmp .loop
		
shell_msg db 10,10,"Shell started",10,0
errorstr db "Error",10,0
buff times 20 db 0
prompt db "run> ",0
		

; DATA
msg_start db 10, "Kernel Loaded",0
msg_loadtable db 10, 10, "FIle Table Loaded",0
BOOT_DEV db 0

start:
	mov al, 0x03
	call setvideo

	mov [BOOT_DEV], dl
	
	mov si, msg_start
	call putstr

	call load_table
	
	mov si, msg_loadtable
	call putstr

	jmp shell

times 512 - ($ - $$) db 0
