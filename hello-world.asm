Foi usado o programa “Meu nome.asm”, de codigo-fonte a seguir:
; Nome do algoritmo :meu nome.asm eh um tipico hello world em ASSEMBLY
 
 
 section .data
  strOla : db "Sergio Souza Novak", 10
  strOlaL: equ $ - strOla

section .text
  global _start

_start:

mov eax, 4
mov ebx, 1
mov ecx, strOla
mov edx, strOlaL
int 0x80

mov eax, 1
mov ebx, 0
int 0x80
