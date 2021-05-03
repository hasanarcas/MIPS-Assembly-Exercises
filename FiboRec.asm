.data
prompt: .asciiz "Recursive function for finding the nth Fibonacci number.\nPlease enter a non-negative value: "
result: .asciiz "Fibo->"
equals: .asciiz " = "
endLine: .asciiz "\n"

.text
main:	
	#ask the user to enter a non-negative value
	la $a0, prompt
	li $v0, 4
	syscall 
	
	#read the number to be found from console
	li $v0, 5
	syscall
	
	move $t2, $v0	#t2 = v0 (v0 = n ==> t2 = n)
	
	#call function to get the Fibo(n)
	move $a0, $t2	#a0 = t2
	move $v0, $t2	#v0 = t2
	jal Fibo	#call Fibo
	move $t3, $v0	#t3 = v0
	
	#print the message to the console
	la $a0, result		
	li $v0, 4
	syscall		#print "Fibo->"
	
	move $a0, $t2
	li $v0, 1
	syscall		#print "n"
	
	la $a0, equals
	li $v0, 4
	syscall		#print "="
	
	move $a0, $t3
	li $v0, 1
	syscall		#print the result
	
	la $a0, endLine
	li $v0, 4
	syscall		#printf "\n"
	
	li $v0, 10
	syscall		#end the programm
	

Fibo:	#calculate the nth Fibonacci number and return it
	
	beqz $a0, zeroResult	#if(a0 == 0) call zeroResult
	beq $a0, 1, oneResult	#if(a0 == 1) call oneResult
	
	#calculate Fibo(n-1)
	addi $sp, $sp, -4		#save the return adress on stack
	sw $ra, 0($sp)
	
	addi $a0, $a0, -1		# n--;
	jal Fibo		#call the Fibo function for n-1
	addi $a0, $a0, 1		#restore the value of n,  n++;
	
	lw $ra, 0($sp)		#restore the return address from the stack
	addi $sp, $sp, 4		#move the stack pointer
	
	addi $sp, $sp, -4		#push the return value to stack
	sw $v0, 0($sp)
	
	
	#calculate Fibo(n-2)
	addi $sp, $sp, -4		#save the return adress on stack
	sw $ra, 0($sp)
	
	addi $a0, $a0, -2		#n-=2
	jal Fibo		#call the Fibo function for n-2
	addi $a0, $a0, 2		#restor the value of n,  n+=2;
	
	lw $ra, 0($sp)		#restore the return address from the stack
	addi $sp, $sp, 4		#move the stack pointer
	
	
	#pop return value from the stack
	lw $s1, 0($sp)
	addi $sp, $sp, 4
	
	#Fibo(n-1) + Fibo(n-2)
	add $v0, $v0, $s1
	jr $ra
	
zeroResult:
	li $v0, 0
	jr $ra
	
oneResult:
	li $v0, 1
	jr $ra

	
