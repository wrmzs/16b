
GRAPHIC_MEMORY_SEG equ 0xa000
TEXT_MEMORY_SEG equ 0xb800

SCREEN_WIDTH equ 320
SCREEN_HEIGHT equ 200


;string address in si
putstr:
	pusha

	mov ah, 0x0e

	.loop:
		lodsb

		cmp al, 0
		je .done
				
		int 10h

		cmp al, 10
		je .line

		jmp .loop

	.done:
		popa
		ret

	.line:
		mov al, 13
		int 10h
		jmp .loop
		

;video mode in al
setvideo:
	pusha
	mov ah, 0x00

	int 10h
	popa
	ret

;char in al
putchar:
	pusha

	mov ah, 0x0e
	int 10h

	cmp al, 10 
	jne .done

	mov al, 13
	int 10h
	
	.done:
		popa
		ret


	
;al = color
;cx = x
;dx = y
draw_pixel:
	pusha
	
	mov ah, 0x0c
	xor bx, bx
	int 10h

	popa
	ret

;al = color
;cx = x
;dh = y
vga_draw_pixel:
	pusha

	mov bx, GRAPHIC_MEMORY_SEG
	mov es, bx

	xor di, di
	xor bx, bx

	.loop:
		cmp dh, 0
		je .next

		add di, SCREEN_WIDTH
		
		dec dh
		jmp .loop

	.next:
		add di, cx
		mov [es:di], al

		popa
		ret
	

		
	

	