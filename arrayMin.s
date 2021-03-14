# Assume that you have an array of 10 elements with base address in $t0. 
# Write an assembly program to find the minimum value from the array and swap it with the last element in the array.

.data
array:   .word 4 5 8 9 4 1 2 3 6 7
newLine: .asciiz "\n"
Msg1:    .asciiz "min = "
Msg2:    .asciiz "Swapping min and last element: "
Msg3:    .asciiz "Last = "

.text
.globl  main
.ent    main
main:   
        ## min = array[0];
        ## for(i=0; i<10; i++)
        ##    { if( array[i] < min)
        ##        min = array[i];  }
        ## min = min + array[9]
	## array[9] = min - array[9]
	## min = min - array[9]
  
	la     $t0, array
	li     $t1, -1              # i 
        lw     $t2, 36($t0)         # array[9]
        lw     $s2, 0($t0)          # min=array[0]

loop:   slti    $t3, $t1, 10        # if i == 10 exit loop
        beq     $t3, $zero, exc
        addi    $t1, $t1, 1         # i++
        sll     $t5, $t1, 2          
        add     $t7, $t0, $t5
        lw      $t4, 0($t7) 	    # get a[i]

        slt     $t6, $t4, $s2       # array[i] < min ?
        beq     $t6, $zero, loop    # no, continue
  
	move    $s2, $t4
         j       loop

exc:    add   $s1, $s1, $s2
	add   $s2, $s2, $t2
        sub   $t2, $s2, $t2
        sub   $s2, $s2, $t2
                    
done:   la $a0, Msg1
        li $v0, 4
        syscall			    # print "min = "

	move $a0, $s1
        li $v0, 1
        syscall       		    # print min
 
	la $a0, newLine 	    # print a newline
	li $v0, 4
	syscall

        la $a0, Msg2
        li $v0, 4
        syscall			    # print "Swapping min and last element: "
	
	la $a0, newLine 	    # print a newline
	li $v0, 4
	syscall

	la $a0, Msg1
        li $v0, 4
        syscall			    # print "min = "

	move $a0, $s2
        li $v0, 1
        syscall       		    # print swapped min

	la $a0, Msg3
        li $v0, 4
        syscall			    # print "last = "
	
	move $a0, $t2 
        li $v0, 1
        syscall 		    # print swapped last element

# Done, terminate program.
	li $v0, 10
	syscall 
    .end main 