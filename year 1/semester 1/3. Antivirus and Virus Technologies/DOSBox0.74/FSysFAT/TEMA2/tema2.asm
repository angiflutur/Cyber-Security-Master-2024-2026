.model small
.stack 100h

.data
    inputFile db "input.txt$", 0  
	key db 05AH  
    buffer db 512 dup(0)       
    bytesRead dw 0               

.code

start:
    mov ax, @data
    mov ds, ax

    call open_input_file

    call process_file

    call close_file

    mov ah, 4Ch
    int 21h

open_input_file:
    mov ah, 3Dh         
    mov al, 0           
    lea dx, inputFile   
    int 21h             
    jc file_error       
    mov bx, ax          
    ret

process_file:
 read_write_loop:
    mov ah, 3Fh        
    mov bx, bx         
    lea dx, buffer     
    mov cx, 512        
    int 21h             
    jc done             
    mov bytesRead, ax   

    cmp bytesRead, 0 
    je done

    lea si, buffer 
    mov cx, bytesRead  
    call xor_encrypt_decrypt

    call close_file

    call open_file_for_write

    mov ah, 40h        
    mov bx, bx          
    lea dx, buffer     
    mov cx, bytesRead   
    int 21h             
    jc done             

    jmp read_write_loop

done:
    ret

close_file:
    mov ah, 3Eh         
    mov bx, bx          
    int 21h            
    ret

open_file_for_write:
    mov ah, 3Ch         
    lea dx, inputFile   
    int 21h             
    jc done             
    mov bx, ax          
    ret

file_error:
    mov ah, 4Ch
    int 21h

xor_encrypt_decrypt:
 xor_loop:
    mov al, [si]        
    xor al, key          
    mov [si], al         

    inc si               
    loop xor_loop        

    ret

end start
