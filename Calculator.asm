section .data
    prompt db 'Enter operation (+, -, *, /): ', 0
    num1 db 'Enter first number: ', 0
    num2 db 'Enter second number: ', 0
    resultMsg db 'Result: ', 0
    newline db 0x0A

section .bss
    op resb 1
    val1 resb 4
    val2 resb 4
    result resb 4

section .text
    global _start

_start:
    ; Print prompt for operation
    mov eax, 4
    mov ebx, 1
    lea ecx, [prompt]
    mov edx, 29
    int 0x80

    ; Read operation
    mov eax, 3
    mov ebx, 0
    lea ecx, [op]
    mov edx, 1
    int 0x80

    ; Print prompt for first number
    mov eax, 4
    mov ebx, 1
    lea ecx, [num1]
    mov edx, 21
    int 0x80

    ; Read first number
    mov eax, 3
    mov ebx, 0
    lea ecx, [val1]
    mov edx, 4
    int 0x80

    ; Print prompt for second number
    mov eax, 4
    mov ebx, 1
    lea ecx, [num2]
    mov edx, 22
    int 0x80

    ; Read second number
    mov eax, 3
    mov ebx, 0
    lea ecx, [val2]
    mov edx, 4
    int 0x80

    ; Convert input strings to integers
    ; (Note: This example assumes single-digit input for simplicity)

    ; Convert val1 to integer
    movzx eax, byte [val1]
    sub eax, '0'
    movzx ebx, byte [val2]
    sub ebx, '0'

    ; Perform operation
    movzx edx, byte [op]
    cmp edx, '+'
    je add
    cmp edx, '-'
    je subtract
    cmp edx, '*'
    je multiply
    cmp edx, '/'
    je divide

    ; Exit with error code if operation is invalid
    mov eax, 1
    mov ebx, 1
    int 0x80

add:
    add eax, ebx
    jmp print_result

subtract:
    sub eax, ebx
    jmp print_result

multiply:
    imul eax, ebx
    jmp print_result

divide:
    xor edx, edx
    div ebx
    jmp print_result

print_result:
    ; Convert result to string (simplified for single-digit results)
    add eax, '0'
    mov [result], al

    ; Print result message
    mov eax, 4
    mov ebx, 1
    lea ecx, [resultMsg]
    mov edx, 8
    int 0x80

    ; Print result
    mov eax, 4
    mov ebx, 1
    lea ecx, [result]
    mov edx, 1
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    lea ecx, [newline]
    mov edx, 1
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
