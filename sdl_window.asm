default rel

%define SDL_INIT_VIDEO 00000020h

section .data
    message db 'Hello, World!',10,0

section .text

extern printf
extern SDL_Init
extern SDL_CreateWindow

    global main

main:
    push rbp
    mov rbp, rsp

    sub rsp, 16
    mov BYTE [rbp-9], 1 ; isRinning flag
    mov QWORD [rbp-8], 0 ; window pointer

    mov al, 0
    lea rdi, [rel message]    ; pointer to message
    call printf wrt ..plt

    mov rdi, SDL_INIT_VIDEO
    call SDL_Init wrt ..plt
    cmp rax, 0
    jnz main_end

    ; Create window
    lea rdi, [rel message]    ; pointer to message
    mov rsi, 100
    mov rdx, 100
    mov rcx, 1024
    mov r8, 768
    mov r9, 0
    call SDL_CreateWindow wrt ..plt
    cmp rax, 0
    jz main_end
    mov [rbp-8], rax

loop1:
    cmp BYTE [rbp-9], 1
    jne main_end
    jmp loop1



main_end:
    add rsp, 16
    pop rbp

    xor rax, rax
    ret
