.model small
.stack 100h
.data
    msg db 'Enter a string: $'
    str db 20 dup('$')
    palindrome_msg db 'The string is a palindrome.$'
    not_palindrome_msg db 'The string is not a palindrome.$'

.code
main proc
    mov ax, @data         ; Initialize data segment
    mov ds, ax

    ; Display input prompt
    mov ah, 09h
    lea dx, msg
    int 21h

    ; Take user input
    mov ah, 0Ah           ; Function to take string input
    lea dx, str
    int 21h

    ; Get the length of the input string
    mov si, offset str + 1 ; SI points to the first character of the string
    mov cx, byte ptr [si]  ; CX stores the length of the string

    ; Set pointers for comparison
    mov di, si             ; DI points to the start of the string
    add si, cx             ; SI points to the end of the string
    dec si                 ; Move SI to the last character (before '$')

    ; Compare the string from the start and end
    mov al, 1              ; Assume the string is a palindrome (set flag to true)
compare_loop:
    cmp cx, 0              ; If length is zero, stop
    je end_comparison
    mov ah, [si]           ; Load character from end (AH)
    mov bl, [di]           ; Load character from start (BL)
    cmp ah, bl             ; Compare characters
    jne not_palindrome     ; If not equal, the string is not a palindrome
    dec si                 ; Move SI backward
    inc di                 ; Move DI forward
    loop compare_loop      ; Loop until all characters are checked

end_comparison:
    ; If palindrome, display success message
    mov ah, 09h
    lea dx, palindrome_msg
    int 21h
    jmp done

not_palindrome:
    ; If not palindrome, display failure message
    mov ah, 09h
    lea dx, not_palindrome_msg
    int 21h

done:
    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
