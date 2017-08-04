



;O objetivo do exercício é usar a Tabela ASCII para transformar maiúscula em minúscula e vice-versa.
; usa uma chamada para funcao do c printf
; fiz para _x64



section .data
    strentrada : db 'Entrada : ', 0
    strsaida : db 'Convert : %s', 10, 0
    strscanf : db '%s',0
section .bss
    strleitura : resb 25
    strleitura1 : resb 25
    strleitura2 : resb 25
extern printf
extern scanf
section .text
global main
main:
    mov r9,0
laco2:
    mov byte [strleitura+r9],0
    inc r9
    cmp r9,25
    jne laco2
    mov rdi, strentrada ; string de controle para printf
    xor rax,rax ;n é ponto flutuante
    call printf
    xor rax,rax
    mov rdi, strscanf
    mov rsi, strleitura
    call scanf
    mov eax,[strleitura]
    cmp eax,'exit'
    je fim
    mov rdi,strleitura
    mov al,[strleitura]
    and al,00100000b
    jnz minuscula
;0 quer dizer que é maiuscula
    call lowercase
    mov rdi,strleitura
    call mostrar
    jmp main
minuscula:
    call uppercase
    mov rdi,strleitura
    call mostrar
    jmp main
fim:
    ret
lowercase:
;criar stack frame
    push rbp
; coloco rbp na pilha
    mov rbp, rsp ; e faço ele aponta pro começo da pilha junto com o rbp
    push r15
    mov r15,0
laco:
    mov al,[rdi+r15]
    or al,00100000b
    mov [rdi+r15],al
    inc r15
    cmp byte [rdi+r15],0
    jne laco
    mov rax,rdi ;retorna minha string convertida,retorno sempre em rax
    pop r15
    mov rsp,rbp
    pop rbp
    ret
uppercase:
    push rbp
    mov rbp,rsp
    push r15
    mov r15,0
laco1:
    mov al,[rdi+r15]
    and al,11011111b
    mov [rdi+r15],al
    inc r15
    cmp byte [rdi+r15],0
    jne laco1
    mov rax,rdi
    pop r15
    mov rsp,rbp
    pop rbp
    ret
mostrar:
    push rbp
    mov rbp, rsp
    push rdi
    mov rdi,strsaida
    mov rsi,[rbp-8]
    xor rax,rax
    call printf
    pop rdi
    mov rsp,rbp
    pop rbp
    RET
