
;Nesta aula aprendemos sobre PONTO FLUTUANTE em assembly, primeiramente foi relembrado a notação ciêntífica de ponto
;flutuante. Vimos uma arquitetura para pontto flutuante. Á essa forma demos a sigla de FPU.
;Foi aprendido também as diferenças da representação de ponto flutuante em _x86 e _x64. Pelo debbugador usamos os
;registradores st0, st1, st2, st3, st4, st5, st6, st7 para observarmos as rotações de uma forma normal de ponto flutuante. Por
;desenhos, podemos compreender mais como funciona a rotação em ponto flutuante, que primeiramente parecia muito confusa.
;Na aritmética de ponto flutuante aprendemos várias instruções de ponto flutuante, tais como FADD, FADDp, FSUB, FSUBP.
;Para se zerar o registrador usa-se ffree sti. O professor indicou uma leitura auxiliar da documentação do montador NASM. Para
;a forma normal de ponto flutuante o professor também indicou leitura auxiliar. E ainda posteriormente com o exercício de
;báskara aprendemos na prática como operar pontos flutuantes em assembly.
;Para este exercício,foram utiliados os comandos:
;básicos aritméticos como o “fadd” e o “fsub”, comando para zerar registrador “ffree”, também o para calcular raíz quadrada,
;“fsqrt”, referência do slide. Foi usado també o comando negar “fchs”.Depois foi
;usado o “fld” para armazenar os valores no registrador, após isso, no sti e o comando “fst”, armazenando os valores do sti nas
;memórias . No meu caso usei arquitetura _x64 com seu protocolo para chamada de função.



section .data
 entrada : db "Informe os valores de A,B E C: ", 10, 0
 valor : db "%lf %lf %lf",0
 raiz1 : db "x1 = %lf", 10, 0
 raiz2 : db "x2 = %lf", 10, 0
 rn : db 'n'
 rp : db 'p'
 ;não foi necessario passar por parâmetro
 f4 : dq 4.0
 f2 : dq 2.0
section .bss
 A : resq 1
 B : resq 1
 C : resq 1
 r : resb 1
 x1 : resq 1
 x2 : resq 1
 extern printf
extern scanf
section .text
 global main
main:
 sub rsp, 8
 xor rax,rax

 mov rdi,entrada
 call printf
 mov rax,3
 mov rdi,valor
 mov rsi,A
 mov rdx,B
 mov rcx,C
 call scanf
 add rsp,8
 xor rcx,rcx
 mov rdi,[A]
 mov rsi,[B]
 mov rdx,[C]
 mov cl,[rn]
 call baskara
 mov [x1],rax
 xor rax,rax
 mov rdi,[A]
 mov rsi,[B]
 mov rdx,[C]
 mov cl,[rp]
 call baskara
 mov [x2],rax
 xor rax,rax
raizP:
 sub rsp,8
 mov rax,
1
 movlps xmm0, [x1]
 mov rdi, raiz1
 call printf
 add rsp, 8
raizN:
 sub rsp,8
 mov rax, 1
 movlps xmm0, [x2]
 mov rdi, raiz2
 call printf
 jmp fim
baskara:
 push rbp
 mov rbp,rsp ]
; para a funcao rbp é base de pilha
;salvamento das variaveis locais
 sub rsp,56

 mov [rbp
-24],rdx
 fld qword [rbp
-24]
 mov [rbp
-8],rdi

 fmul qword [rbp
-8]


 fmul qword [f4]
 fst qword [rbp
-32]
 ffree st0

 mov [rbp
-16],rsi
 fld qword [rbp
-16]
 fmul qword [rbp
-16] ;
 ;st0= B * B
 fsub qword [rbp
-32]
 fsqrt ;invoca raiz quadrada
 fst qword [rbp
-40]
 ffree st0 ; pseudoinstrucao para zerar o st0
cmp cl,[rp]
jne NEGATIVO
fld qword [rbp
-16]
 fchs 
  fadd qword [rbp
-40]
 fst qword [rbp
-48]
 ffree st0
 fld qword [rbp
-8]
 fmul qword [f2]
 fst qword [rbp
-56]
 ffree st0
 fld qword [rbp
-48]

 fdiv qword [rbp
-56]
 jmp retorno
NEGATIVO:
 fld qword [rbp
-16]
 fchs
 fsub qword [rbp
-40]
 fst qword [rbp
-48]
 ffree st0
 fld qword [rbp
-8]
 fmul qword [f2]
 fst qword [rbp
-56]
 ffree st0
 fld qword [rbp
-48]

 fdiv qword [rbp
-56]
retorno:
 fst qword [rbp
-56]
mov rax,[rbp
-56]

 mov rsp,rbp
 pop rbp
 ret
fim:
;alinhamento de printf
add rsp, 8
ret
