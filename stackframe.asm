;Nesta aula foras estudadas as sub-rotinas em assembly que são invocadas por CALL e finalizadas somente com chamado
;RET. O parâmetro para o chamador CALL é um label. Qualquer retorno da função será dado por pilha ou implícito no
;registrador EAX. Foi visto também o protocolo _x86 e _x64 para chamada de função e todos os passos, incluindo o stackframe
;conceito esse muito interessante para se entender como funciona a pilha e a sua operação para funções.


%define WRITE 4
%define EXIT 1
%define KERNEL 0x80
section .data
    strTeste1 : db 'string null-terminated', 0
    strTeste2 : db 'outra string null-terminated', 0 ; 28 + 1
    strTeste3 : db 'Yes Captain', 0
section .bss
    str1L : resd 1
    str2L : resd 1
    str3L : resd 1
section .text
global _start
_start:
; valores teste dos registradores
    mov rax, 1
    mov rcx, 3
    mov rdx, 4
; save registers RAX, RCX e RDX
    push rax
    push rcx
    push rdx
    mov rdi, strTeste1
    call strLenght
; retorno da sub-rotina em EAX
    mov [str1L], eax
; tirar da STACK
    add rsp, 4
    pop rdx
    pop rcx
    pop rax
teste:
; valores para teste de salvamento de registradores
    mov rax, 1
    mov rcx, 3
    mov rdx, 4
; passo 1 - Antes da chamada CALL
; salve registers RAX, RCX e RDX
    push rax
    push rcx
    push rdx
    mov rdi, strTeste2
;chamada por CALL
    call strLenght
; retorno da sub-rotina no EAX
    mov [str2L], eax
; passo 4
; remover parâmetros da PILHA
add rsp, 4 ; +4 para cada parâmetro empilhado. 4B = Cada endereço tem 32 bits
; passo 5
; recuperar registradores RAX, RCX e RDX
    pop rdx ; último empilhado
    pop rcx
    pop rax ; primeiro empilhado
teste2:
; valores para teste de salvamento de registradores
    mov rax, 1
    mov rcx, 3
    mov rdx, 4
; passo 1 - Antes da chamada CALL
; salvar registradores RAX, RCX e RDX
    push rax
    push rcx
    push rdx
; passo 2 - Antes da chamada CALL
; empilhar parâmetros da direita para esquerda
    mov rdi, strTeste3
; passo 3 - chamada CALL
    call strLenght
; retorno do sub-programa em EAX
mov [str3L], eax
; passo 4
; remover parâmetros da PILHA
    add rsp, 4 ; +4 para cada parâmetro empilhado. 4B = Cada endereço tem 32 bits
; passo 5
; recuperar registradores RAX, RCX e RDX
    pop rdx ; último empilhado
    pop rcx
    pop rax ; primeiro empilhado
fim:
    mov eax, EXIT
    mov ebx, 0
    int _kernel
strLenght:
    push rbp
    mov rbp, rsp
sub rsp, 4 ; 4 bytes para uma variável inteira local
;Uso do Deslocador
    mov dword [rbp-4], 0
laco:
    mov edx, [rbp-4] ; deslocador
    mov al, [rdi+rdx] ; char[deslocador]
;Para /0
    cmp al, 0
; teste para ver se o char está zerado
je finaliza
    inc edx
; desloc=desloc+1
    mov [rbp-4], edx ; guarda deslocador
    jmp laco
finaliza:
mov eax, [rbp-4] ;retorno da função
;Stack-frame
    mov rsp, rbp
    pop rbp
    ret
