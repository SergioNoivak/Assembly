


section .data
  v1: db 10d
  v2: dw -20d
  v3: dq -30d

section .bss
  n1: resb 1
  n2: resb 2
  n3: resb 8

 section .text
global _start

_start:

mov ah,[v1]
mov byte [n1], ah
mov bx,[v2]
mov word [n2], bx
mov rcx,[v3]
mov qword [n3], rcx

fim:
mov rax, 1
mov rbx, 0
int 80h
