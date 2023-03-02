[org 0x7c00]

STACK equ 0x8000
KERNEL equ 0x9000

jmp start


msg_boot db "Loading kernel...",10,13,0
msg_loaded db "Kernel sectors loaded!",10,13,0
msg_jmp db "Jumping to kernel start...",10,13,0

print:
	pusha
	
	mov ah, 0x0e

	.loop:
		lodsb
		cmp al, 0
		je .done
		int 10h

		jmp .loop
		
	.done:
		popa
		ret


loadsector:
	pusha
	
	mov ah, 0x02
	mov al, 1
	xor ch, ch

	;sector in cl
	;drive in dl

	xor dh, dh

	;es:bx buffer

	int 13h

	jc error

	popa
	ret

error:
	hlt
	

start:
	mov ax, STACK
	mov sp, ax
	mov bp, ax
	
	xor ax, ax
	mov ss, ax

	mov si, msg_boot
	call print
	
	mov cl, 3
	xor ax, ax
	mov es, ax
	mov bx, KERNEL
	
	call loadsector

	mov si, msg_loaded
	call print

	mov si, msg_jmp
	call print
	
	jmp KERNEL
		

times 510 - ($ - $$) db 0

dw 0xaa55

