;buffer in di
;count in ch
fill:		
	mov al, 0

	.loop:
		dec ch
		stosb

		cmp ch, 0
		je .done
		
		jmp .loop

	.done:
		ret


;str1 in si
;str2 in di
;len in ah
cmpstr:	
	push si
	push di
	
	.loop:
		dec ah

		lodsb
		cmp al, [di]
		jne .done

		cmp ah, 0
		je .done

		inc di
		jmp .loop
		
	.done:
		pop di
		pop si
		ret