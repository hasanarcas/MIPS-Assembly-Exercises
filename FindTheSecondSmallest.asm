#Hasan ARCAS 180709026

.data
	values: .word 7, 7, 7, 8, 7
	size: .word 5
	if_all_equal: .asciiz "There is No second smallest\n"

.text
main:						# main()
	la $t4 values				# t4= values' base address
	lw $t5, 0($t4)				# t5= values[0]
	lw $t6, size				# t6= size
	add $t2, $zero, $zero			# iterator (i = 0)
	lw $t0, 0($t4)				# t0 = smallest values (in the beginning values[0]
	lw $t1, 0($t4)				# t1= second smallest value (also values[0] when created)		

Loop:						# Loop()
	add $t2, $t2, 1 			# i+= 1
	ble $t6, $t2, Break			# if t6 <= t2: Break()
	addi $t4, $t4, 4			# t4 = values[i+1]'s address
	lw $t5, 0($t4)				# t5 = values[i+1]
	blt $t5, $t0, ifSmallerThanT0		# if values [i+1] < t0 (the smallest number): ifSmallerThanT0() 
	blt $t5, $t1, ifSmallerThantT1		# if values [i+1] < t1 (the second smallest number): ifSmallerThanT1()
	bgt $t5, $t1, ifBiggerThanT1		# if values [i+1] > t1 (the second smallest number): ifBiggerThanT1()
j Loop						# Go back to the beginning of Loop()
		
	
ifBiggerThanT1:					# ifBiggerThanT1()
	beq $t0, $t1, ifSmallerThantT1		# if t1==t0: ifSmallerThanT1()   (the second smallest element is now become values[i+1]
j Loop						# Go back to the beginning of Loop()	
	
ifSmallerThantT1:				# ifSmallerThantT1()					
	beq $t5, $t0, Loop			# if values[i+1] == t0: Loop()   (don't change the second smallest's value, go back the Loop())
	addi $t1, $t5, 0			# t1 = t5 (second smallest number is now become values[i+1]
j Loop						# Go back to the beginning of Loop()
	
ifSmallerThanT0:				# ifSmallerThanT0()
	addi $t1, $t0, 0			# t1= t0 (the second smallest number is now become the smallest number)
	addi $t0, $t5, 0			# t0= t5 (the smallest number is now become values[i+1]
j Loop						# Go back to the beginning of Loop()

	
Break:						# Break()
	beq $t0, $t1, ifAllEqual		# if all the values are equal: ifAllEqual()
	
	li $v0, 1				# prepare to print the second smallest element
	addi $a0, $t1, 0
	syscall
	
	li $v0, 10				#prepare to print the program
	syscall
	
ifAllEqual:
	li $v0, 4				#prepare to print the content of if_all_equal
	la $a0, if_all_equal
	syscall
	
	li $v0, 10				#end
	syscall

