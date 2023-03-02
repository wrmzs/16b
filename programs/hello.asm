[org 0x9400]

jmp start

%include "include/16b.asm"

msg db "Hello, world!",10,0

start:
	mov si, msg
	call putStr

	ret
