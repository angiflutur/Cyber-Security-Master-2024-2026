.model small

Add2 MACRO op1, op2, Sum
	mov AX, op1
	add AX, op2
	mov Sum, AX
ENDM

exit_dos MACRO
	mov AX, 4c00h
	int 21h
ENDM

.stack 10h

.data
	a dw 9
	b dw -2
	S dw ?
	
.code
	start:
	mov AX, @data
	mov DS, AX
	
	Add2 a, b, S
	exit_dos
	end start