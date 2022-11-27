# setup.s
.text

__start:

.globl __start
   call main
 
finish:
 mv a1, a0 # a1 = a0
 li a0, 17 # a0 = 17
 ecall # выход с кодом завершения