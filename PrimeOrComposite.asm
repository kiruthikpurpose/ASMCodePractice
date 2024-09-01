section .data
    num db 29
    msg_prime db 'Prime', 0
    msg_composite db 'Composite', 0
    newline db 0x0A

section .bss
    result resb 9

section .text
    global _start

_start:
    mov al, [num]
    cmp al, 2
    jl not_prime
    cmp al, 2
    je print_prime

    mov bl, 2
    mov cl, al
    shr cl, 1

check_divisor:
    mov ah, 0
    div bl
    cmp ah, 0
    je print_composite

    inc bl
    cmp bl, cl
    jle check_divisor

print_prime:
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_prime]
    mov edx, 5
    int 0x80
    jmp exit

print_composite:
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_composite]
    mov edx, 9
    int 0x80

exit:
    mov eax, 4
    mov ebx, 1
    lea ecx, [newline]
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
