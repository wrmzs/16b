[org 0x9400]

jmp start

;si str
;cl count
putStrCount:
	pusha
	
	.loop:
		dec cl
		lodsb
		call putChar

		cmp cl, 0
		jg .loop

	popa
	ret
	

start:
	mov si, FILE_TABLE

	.loop:
		mov cl, 8
		call putStrCount
		add si, 8

		mov al, 10
		call putChar

		mov al, [si]
		cmp al, 0
		je .done
		
		cmp si, FILE_TABLE + 511
		jge .done
		
		jmp .loop

	.done:
		ret



%include "include/16b.asm"
