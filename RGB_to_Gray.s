# Write an assembly program to convert red-green-blue (RGB) values for a set of pixels into a single gray value per pixel.
# You are given an array called pixels, each element of which is a 32-bit word representing a color value. 
# The lowest 8 bits of each color value denote an unsigned integer representing the BLUE value, the next 8 bits are the GREEN value, the next 8 bits are the RED value, and the most significant 8 bits are all zeroes. 
# gray value = (red + green + blue) / 3 (integer divide and truncate). 
# Use a separate procedure rgb2gray and print each RGB value and the corresponding gray value on the console.
.data
startString:  .asciiz "Converting pixels to grayscale:\n"
finishString: .asciiz "Finished.\n"
Msg1:         .asciiz "\nRGB Value: "
Msg2: 	      .asciiz "  Gray Value: "
newline:      .asciiz "\n"
pixels:       .word   0x00010000, 0x010101, 0x6, 0x3333, 0x030c, 0x700853, 0x294999, 0x0001ff22, -1
Red:          .word   0x00FF0000

	.text
	.globl  main
	.ent    main
main:           	
  	 la $a0, startString 
         li $v0, 4   
 	 syscall               	# print "Converting pixels to grayscale:\n"
 	
	 la $s0, pixels 
	 li $t0, 0  		# i = 0
	 li $s1, -1             # pixels - terminator
	 la $t1, Red
	 lw $s2, 0($t1)
	 li $s3, 3              

loop:    sll $t1, $t0, 2
	 add $t1, $t1, $s0
         lw  $t2, 0($t1) 	# get pixels[i]

	 la $a0, Msg1
         li $v0, 4
         syscall		# print "\nRGB Value: "

	 li      $v0, 1              # print sum
         move    $a0, $t2
         syscall	        # print RGB value

	 la $a0, Msg2
         li $v0, 4
         syscall		# print "  Gray Value: "

         addi $t0, $t0, 1	# i++
	
	 beq  $t2, $s1, done    # if pixels[i] == -1 goto done

	 # pixel value of the form 0x00RRGGBB
	 and $t5, $t2, $s2
	 srl  $a0, $t5, 16
	 andi $t6, $t2, 0xFF00
	 srl  $a1, $t6, 8
	 andi $a2, $t2, 0xFF
	 jal rgb2gray
         j loop
rgb2gray: add $t3, $a0, $a1
	  add $t3, $t3, $a2
	  div $t4, $t3, $s3
	
	  li      $v0, 1              # print sum
          move    $a0, $t4
          syscall		# print gray value
	  
	  jr $ra 

done:     li $v0, 10
	  syscall 
    .end main 
	  
	 