#Hasan ARCAS 180709026

.data
prompt:.asciiz "Recursive function for finding the nth Fibonacci number.\nPlease enter a non-negative value: "
result: .asciiz "Fibo->"
equals: .asciiz " = "
endLine: .asciiz "\n"

.text
main:
	li $v0,4
	la $a0,prompt		#ask the user to enter a non-negative value
	syscall
	
	li $v0,5		#read the number to be found from console
	syscall
	
	add $a0,$v0,$zero
	jal Fibo		# call the Fibo() func
	
	add $a0,$v0,$zero	#a0 = v0

	li $v0,1
	syscall			#print the result
	
	li $v0,10
	syscall			#end the program

Fibo:
	addi $t0, $zero, 1		#t0 = 1
	beq $a0, $zero, zeroResult	#if(a0 = 0) call zeroResult 
	beq $a0, $t0, oneResult		#if(a0 = 1) call zeroResult
	addi $t1, $zero, 0		#t1 = 0
	addi $t2, $zero, 0		#t2 = 0
	addi $t3, $zero, 1		#t3 = 1
	addi $t4, $zero, 1		#t4 = 1

While:
	bge $t4, $a0, Answer		#if(t4 > a0) return Answer
	add $t1, $t2, $t3			# t1 = t2 + t3
	addi $t2, $t3, 0		# t2 = t3
	addi $t3, $t1, 0		# t3 = t1
	addi $t4, $t4, 1		# t4++;
	j While				#jumpback to the beginning of while and do all again

Answer:
	add $v0, $zero, $t1		
	jr $ra				
	
zeroResult:
	li $v0, 0
	jr $ra
	
oneResult:
	li $v0, 1
	jr $ra
