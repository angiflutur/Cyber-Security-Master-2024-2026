.model small

; void strcpy/memcpy (char* dst, char* src, ...)
EXIS_DOS MACRO
	mov AX, 4c00h
	int 21h
ENDM

SRCSEG SEGMENT
	src db 'ASM x86 on 16 bits$'
	dimSrc dw $-src
SRCSEG ENDS

DSTSEG SEGMENT
	dst db '111111111111111$'
	dimDst dw $-dst
DSTSEG ENDS
	
MainProgSEG SEGMENT
 ASSUME CS: MainProgSEG, DS:SRCSEG, ES:DSTSEG
 start:
	mov AX, SEG src
	mov DS, AX
	
	mov AX, SEG dst
	mov ES, AX
	
	cld		;clear direction flag
	mov SI, offset src
	mov DI, offset dst
	mov CX, dimSrc
	
	rep movsb
	;label_while:
	;	movsb 
	;loop label_while:
	
	;exit_dos
	
MainProgSEG ENDS
 end start