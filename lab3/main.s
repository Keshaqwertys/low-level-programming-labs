.rodata
array_length:
  .word 5
msg1: .string "Enter the number by which you want to shift the array: "
msg2: .string "Result: ["
msg3: .string "]"
separator: .string ", "
  
.data
array:
  .word 1, 2, 3, 4, 5

.text
main:
.global main

li t2 0 #delta - количество разрядов, на которое нужно сдвинуть массив
li t3 2 #const 2                   
#print msg1 ("Enter the number by which you want to shift the array: ")
li a0,4     
la a1, msg1 
ecall     
#enter the number  
li a0, 5    
ecall       
mv t2, a0           #delta = (input number)  
la a3, array_length #a3 = адресс array_length
lw a3, 0(a3)        #a3 = длина массива(array_length)
mv a5, a3           #a5 = длина массива(const.)
la a2, array        #a2 = адресс первого элемента array(iterator)
mv a4, a2           #a4 = адресс первого элемента array(const.)
beq t2, zero, finish#проверка равенства t2(delta) = zero,  t2 = 0 -> jump to finish
addi sp, sp, -16    #выделение памяти в стеке
sw ra, 12(sp)       #сохранение
call sorting        #вызов подпрограммы sorting
lw ra, 12(sp)       #востанавливаем
addi sp, sp, 16     #освобождение памяти в сетке
finish:                   
#print msg2 ("Result: [")
li a0, 4
la a1, msg2
ecall
read:
  beq a3, zero, end        #проверка равенства a3(array_length) = zero,  a3 = 0 -> jump to end_loop
  lw t0, 0(a2)             #t0 = текущий элемент массива
  li a0, 1                 #печать элемента массива
  mv a1, t0
  ecall
  bgeu a3, t3, print_separator #проверка равенства a3(array_length) >= t5(2),  a3 >= 2 -> jump to print_separator
  j skip                       #jump to skip(пропуск печати ", "(separator))
  print_separator:
  li a0, 4                     #печать separator(", ")
  la a1, separator
  ecall
  skip:
  addi a2, a2, 4          #iterator += 1 Переходим на следующий элемент массива 
  addi a3, a3, -1         #a3(array_length) -= 1
  j read
end:
li a0, 4                  #печать msg3("]")
la a1, msg3
ecall
ret
