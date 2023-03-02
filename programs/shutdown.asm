[org 0x9400]

jmp start

%include "include/16b.asm"

start:
	mov ax, 0x5307
	mov bx, 0x0001
	mov cx, 0x0003
	int 15h

	ret
