# load two numbers from memory into registers, add them,
# and store their sum

	.data
one:	.word	1
two:	.word	2
sum:	.word   -1
	.text
main:
	lw   $t0,one
	lw   $t1,two
	add  $t2,$t0,$t1
	sw   $t2,sum

	jr   $ra      # return

