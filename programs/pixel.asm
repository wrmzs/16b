[org 0x9400]

jmp start

%include "include/16b.asm"

start:
	mov al, 0x13
	call setVideo

	mov al, 0x0a
		
	xor cx, cx
	xor dh, dh

	.x1:
		cmp cx, 320
		je .y1

		call drawPixel

		inc cx
		jmp .x1

	.y1:
		mov cx, 319
		cmp dx, 200
		je .x2

		call drawPixel
		
		inc dx
		jmp .y1

	.x2:
		mov dx, 199
		cmp cx, 0
		je .y2

		call drawPixel

		dec cx
		jmp .x2

	.y2:	
		dec dx
		cmp dx, 0		
		je .done
		
		call drawPixel
		jmp .y2
	
	.done:
		call readChar
	
		mov al, 0x03
		call setVideo
	
		ret
