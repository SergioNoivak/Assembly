;Esta foi a última aula do semestre, foi estudada a Taxonomia de Flynn, e conjunto de instruções vetoriais para
;inteiros MMX(MultiMedia eXtension ou Matrix Math eXtensions). Não é possível utiliza-los ao mesmo tempo,
;MMX e FPU.
;Apreendemos as instruçoes:
;emms, movd, movq
;e também outras instruções MMX. No exercício da disciplina pudemos usar nossa criatividade para operar com
;um vetor de inteiros usando MMX. Também foi aprendido o dslocamento aritmético com MMX.


%define EXIT

section .data
  vetor : db 2,1,0,0,0,0,0,0
  vetor4: db 1,4,1,0,0,0,0,0
   vetor1: dd 6, 0
   vetor2: dd 0, 2
   vetor3: dw 8,0,0,0
   vetor5: dw 1,2,0,0
section .bss
   vetorN: resd 2 ; para armazenar resultados
   vetorN1: resb 8
   vetorN2: resw 4
   vetorOL: resb 8 ;efetuar as operacoes logicas
   vetorOL1: resd 2

section .text
global main

main:
bum:
   movq mm0,[vetor]
   movq mm1,[vetor4]
   pxor mm0,mm1
   movq [vetorOL],mm0
P1:
   movq mm0,[vet1]
   movq mm1,[vet2]
   por mm0,mm1
   movq [vetOL1],mm0
bum1:
   movq mm0,[vetor1] ;soma
   movq mm1,[vetor2]
   paddd mm0,mm1
   movq [vetorN],mm0
   movq mm0,[vetor]
   movq mm1,[vetor4]
   paddusb mm0,mm1
   movq [vetorN1],mm0
   movq mm0,[vetor3]
   movq mm1,[vetor5]
   paddw mm0,mm1
   movq [vetorN2],mm0
subtracao:
   movq mm0,[vetor1] ;subtração
   movq mm1,[vetor2]
   psubd mm0,mm1
   movq [vetorN],mm0
   movq mm0,[vetor]
   movq mm1,[vetor4]
   psubusb mm0,mm1
   movq [vetorN1],mm0
   movq mm0,[vetor3]
   movq mm1,[vetor5]
   psubw mm0,mm1
   movq [vetorN2],mm0
   emms
fim:
mov eax, EXIT
mov ebx,0
int 0x80
