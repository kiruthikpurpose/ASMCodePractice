section .data
    newline db 0x0A

section .bss
    num resb 4

section .text
    global _start

_start:
    mov ecx, 1

print_loop:
    mov eax, ecx
    add eax, '0'
    mov [num], eax

    mov eax, 4
    mov ebx, 1
    mov edx, 1
    lea ecx, [num]
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov edx, 1
    lea ecx, [newline]
    int 0x80

    inc ecx
    cmp ecx, 11
    jl print_loop

    mov eax, 1
    xor ebx, ebx
    int 0x80
