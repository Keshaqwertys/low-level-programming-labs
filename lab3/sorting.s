# sorting.s
.text
sorting:
.globl sorting

globl_loop:
  loop:
    beq a3, zero, end_loop  #проверка равенства a3(array_length) = zero,  a3 = 0 -> jump to end_loop
    lw t0, 0(a2)            #текущий элемент(t0) = значение элемента массива array
    sw t1, 0(a2)            #текущий элемент массива = предыдущий элемент(t1)
    mv t1, t0               #предыдущий элемент(t1) = текущий элемент(t0)
    addi a2, a2, 4          #iterator += 1 Переходим на следующий элемент массива
    addi a3, a3, -1         #array_length -= 1
    j loop
  end_loop:  
  sw t1, 0(a4)              #первый элемент массива array = предыдущий элемент(t1)
  mv a3, a5                 #a3 = array_length
  mv a2, a4                 #iterator = адресс первого элемента array
  addi t2, t2, -1           #delta -= 1
  beq t2, zero, finish      #проверка равенства t2 = zero,  a3 = 0 -> jump to finish
j globl_loop
finish:
ret