# Assume that you have an array of 10 elements with base address in $s0. Assume that the base address of a second array is in $t0. 
# Write an assembly program to copy the elements from the first array to the second.
.data

array1:   .word 4 5 8 9 4 1 2 3 6 7
array2:   .word 0 0 0 0 0 0 0 0 0 0
Space:    .asciiz " "
Msg:      .asciiz "array2(copied from array1) = "

.text
.globl  main
.ent    main
main:  
	la $s0, array1
	la $t0, array2
        li $t1, -1      #i

        la $a0, Msg
	li $v0, 4
        syscall	       # print "array2(copied from array1) = "
	
  
loop:   slti $t2, $t1, 10	#if i==10 exit loop
	beq  $t2, $zero, done
        addi $t1, $t1, 1 	#i++

	sll $t3, $t1, 2
	add $t4, $t3, $s0
	lw $t5, 0($t4)          #array1[i]
        add $t6, $t3, $t0
	sw $t5, 0($t6)          #array2[i] = array1[i]
        
	lw $t7, 0($t6)
	move $a0, $t7
	li $v0, 1               #print copied element
	syscall 

	la $a0, Space   	#print space
	li $v0, 4
	syscall

	j loop

done:   li $v0, 10
	syscall 
  .end main 


	  