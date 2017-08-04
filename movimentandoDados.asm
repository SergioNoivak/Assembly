:O código tem como objetivo ensinar a movimentar dados em ASSEMBLY,
;analisar o uso do MOV e registradores

section .data

  pt1r8 : db 0x10
  pt1r16 : dw 0x2020
  pt1r32 : dd 0x30303030
  pt1r64 : dq 0x4040404040404040

 section .text
    global _start
_start:
  mov ah, [pt1r8]
  mov r8W, [pt1r16]
  mov r9D, [pt1r32]
  mov r10, [pt1r64]

fim:
  mov rax, 1
  mov rbx, 0
  int 0x80
