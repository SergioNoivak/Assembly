;Este código fonte serviu para estudar como os dados sinalizados em ASSEMBLY podem 
;ser expandidos na sua movimetacao

section .data
  v1: db 10d
  v2: dw -20d
  v3: dw -30d

section .bss
  n1: resq 1
  n2: resq 1
  n3: resq 1

 section .text
global _start

_start:
  movsx rax,byte [v1]
  mov [n1], rax 
  movsx rbx,word [v2]
  mov [n2], rbx
  movsx rcx,word [v3]
  mov [n1], rax

fim:
  mov rax, 1
  mov rbx, 0
  int 0x80
