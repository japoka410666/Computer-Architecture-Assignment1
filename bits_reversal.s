.data
INPUT:.word 0b11111111111111111111111111111101
str:  .string " is reversed to "

.text
main:
    lw  s0, INPUT     #laod the input
    li  s1, 0         #initialize the result to zero
    add a0, s0, x0    #load the input into function
    li  a1, 0         #initialize the return val of func
    jal reverse
    add s1, a1, x0    #save the return val
    jal print
    li  a7, 10        #call system to end the program
    ecall
reverse:
    addi sp, sp, -8   #save the arguments
    sw  ra, 4(sp)     #return address
    sw  a0, 0(sp)     #input
    li  t1, 0         #initialize the result
    li  t2, 0         #initialize the iterator i
    loop:
        andi t0, a0, 1          #mask input with 1
        sub  t3, x0, t2         # -(i)
        addi t3, t3, 31         # 31 - i
        sll  t0, t0, t3         # <<(31 - i)
        add  t1, t1, t0         # accumualte the result in a1
        srli a0, a0, 1          # input = input >> 1
        addi t2, t2, 1          # accumualte i
        slti t0, t2, 32         # test if i < 32
        bne  t0, x0, loop
        bnez a0, loop           # test if n == 0
    add  a1, x0, t1    #save the result
    lw   a0, 0(sp)     #laod the original input   
    lw   ra, 4(sp)     #laod the return address
    addi sp, sp, 8     #recover sp
    jr   ra            #return

#Print the result in console
print:
    lw a0, INPUT
    li a7, 35        #call system to print binary int (input)
    ecall
    la a0, str
    li a7, 4         #call system to print string
    ecall
    mv a0, s1
    li a7, 35        #call system to print binary int (result)
    ecall
    jr ra
