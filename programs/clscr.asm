[org 0x9400]

jmp start

%include "include/16b.asm"

start:
	mov al, 0x03
	call setVideo

	ret
