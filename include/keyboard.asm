;buffer in di
readchar:
	push ax
	mov ah, 0x00
	int 16h

	mov bl, al

	pop ax
	mov al, bl
	
	ret


;buffer in di
;max in ah
readstr:
	pusha
	mov ch, 0

	dec ah
	
	.loop:
		cmp ch, ah
		je .done
		
		call readchar

		cmp al, 13
		je .done

		cmp al, 8
		je .back

		call putchar

		stosb

		inc ch	
		jmp .loop

	.done:
		mov al, 10
		call putchar

		mov al, 0
		stosb
		
		popa
		ret

	.back:
		cmp ch, 0
		je .loop
		
		call putchar
		mov al, 32
		call putchar
		mov al, 8
		call putchar

		mov al, 0
		mov [di], al
		dec di
		
		dec ch
		jmp .loop