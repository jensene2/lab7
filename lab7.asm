%include "asm_io.inc"
segment .data 
Prompt	db	"Enter 1 number:", 0
Output	db	"Odd Sum =", 0

segment .bss 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
	;***************CODE STARTS HERE***************************
	
	mov	eax, Prompt
	call	print_string

	call	read_int
	push	eax

	mov	eax, Output
	call	print_string

	call	SumOdd
	call	print_int
	call	print_nl	

	pop	eax

	;***************CODE ENDS HERE*****************************
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

; subprogram SumOdd
; Parameters:
;	A single value passed in via the stack.
; Notes:
;	Overwrites eax, ecx and edx
SumOdd:
	enter	4, 0

	mov	dword [ebp-4], 0
	mov	ecx, 1
	mov	edx, [ebp+8]
loop:
	cmp	ecx, edx

	; If they are equal, we're done.
	jz	finish
	; If ecx > ecx, we're done.
	jnl	finish

	add	[ebp-4], ecx
	
	add	ecx, 2
	jmp	loop
finish:

	mov	eax, [ebp-4]	

	leave
	ret

