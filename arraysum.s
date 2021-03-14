# Calculate and print the sum of an integer array

        .data

array:  .word 1 2 3 4 5

        .text
        .globl main

main:   

        ## sum = 0;
        ## for(i=0; i<5; i++);
        ##    sum = sum + array[i];

        li      $t0, 0              # sum = 0
        li      $t1, 0              # i (index) = 0

loop:   slti    $t3, $t1, 5         # if i == 5 goto done
        beq     $t3, $zero, done

        la      $t5, array          # fetch a[i]
        sll     $t6, $t1, 2
        add     $t5, $t5, $t6
        lw      $t4, 0($t5)

        add     $t0, $t0, $t4       # add a[i] to sum

        addi    $t1, $t1, 1         # i++
        j       loop


done:   li      $v0, 1              # print sum
        move    $a0, $t0
        syscall

        li      $v0, 11             # print newline character
        li      $a0, 0x0a
        syscall

        jr $ra                      # return from main
