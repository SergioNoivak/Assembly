
;O exercício tem como objetivo usar a pilha, por isso, usei os comandos POP e PUSH:

section .bss
  v1 : resb 255
  v2 : resb 255
  argc : resq 1

 section .text
global _start

_start:
  pop qword [argc]
;Faz comparação com argc
  cmp qword [argc],3
  jne fim
  pop r10
  pop r10
  pop r11
  mov rcx,0
teste:
  mov al,[r10+rcx]
  mov [v1+rcx],al
  cmp al,0
  je zera
  inc rcx
  jmp teste1
zerador:
  mov rcx,0
teste_segundo:
  mov bl,[r11+rcx]
  mov [v2+rcx],bl
  cmp bl,0
  je renomeando
  inc rcx
  jmp seila1
renomeando:
  mov eax,0x26 ;rename
  mov ebx,v1
  mov ecx,v2
  int 0x80

fim:
  mov eax, 1
  mov ebx, 0
  int 0x80
