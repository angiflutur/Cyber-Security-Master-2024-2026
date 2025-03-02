.model small
.stack 100h

.data
    arr1 dw 15, 9, 6, 25           ; First array with 4 elements
    arr1_size dw 4                 ; Size of the first array

    arr2 dw 7, 9, 0, 12, 6, 8      ; Second array with 6 elements
    arr2_size dw 6                 ; Size of the second array

    arr3 dw 6, 19, 3, 5, 9, 15, 7, 10 ; Third array with 8 elements
    arr3_size dw 8                 ; Size of the third array

    min dw 0FFFFh                  ; Variable to store the minimum value
    max dw 0                       ; Variable to store the maximum value

.code

start:
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax        

    ; Process first array
    mov si, offset arr1      ; Load the address of the first array into SI
    mov cx, arr1_size        ; Load the size of the first array into CX
    call find_min_max        ; Call the procedure to find min and max

    ; Process second array
    mov si, offset arr2      ; Load the address of the second array into SI
    mov cx, arr2_size        ; Load the size of the second array into CX
    call find_min_max        ; Call the procedure to find min and max

    ; Process third array
    mov si, offset arr3      ; Load the address of the third array into SI
    mov cx, arr3_size        ; Load the size of the third array into CX
    call find_min_max        ; Call the procedure to find min and max

    ; Exit the program
    mov ax, 4C00h
    int 21h

; Procedure to find the minimum and maximum values in an array
find_min_max:
    ; Initialize min and max for each new array
    mov min, 0FFFFh          ; Set min to the highest possible value
    mov max, 0               ; Set max to the lowest possible value

    ; Initialize min and max with the first element of the array
    mov ax, [si]             ; Load the first element of the array
    mov min, ax              ; Set min to the first element
    mov max, ax              ; Set max to the first element
    add si, 2                ; Move to the next element
    dec cx                   ; Decrement counter as the first element is processed

process_loop:
    cmp cx, 0                ; Check if all elements have been processed
    je return                ; If yes, exit the loop

    mov ax, [si]             ; Load the current element of the array
    cmp ax, min              ; Compare it with the current min
    jge check_max            ; If greater or equal, skip to max check
    mov min, ax              ; Update min if a smaller value is found

check_max:
    cmp ax, max              ; Compare it with the current max
    jle skip_update_max      ; If less or equal, skip max update
    mov max, ax              ; Update max if a larger value is found

skip_update_max:
    add si, 2                ; Move to the next element
    dec cx                   ; Decrement the counter
    jmp process_loop         ; Repeat the loop for the next element

return:
    ret                      ; Return from the procedure

end start
