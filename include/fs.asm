;filename in si
search_file:
	mov cl, 0
	mov di, FILE_TABLE
	
	.loop:
		inc cl
		
		cmp cl, 64
		jg .notfound
				
		mov al, [di]
		cmp al, 0
		je .loop
		
		mov ah, 8
		call cmpstr
		je .found

		add di, 8
		
		jmp .loop

	.found:
		add cl, 3
		ret

	.notfound:
		mov cl, 0
		ret

	

;si file_name
;es:bx buffer
load_file:	
	call search_file
	cmp cl, 0
	jne .step2

	ret

	.step2:
		call loadsector
		ret

;si - program name
run_program:
	pusha
	
	xor ax, ax
	mov es, ax
	mov bx, PROGRAM

	call load_file
	cmp cl, 0
	jne .step2

	popa

	mov cl, 0
	ret

	.step2:
		call PROGRAM
		
		popa		
		mov cl, 1
		ret

		