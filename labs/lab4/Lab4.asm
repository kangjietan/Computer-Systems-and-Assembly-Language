#$t0 = prompt number, $t1 = counter, $t2 = remainder for 3, $t3 = int 3, $t4 = int 4, $t5 = remainder for 4, $t6 = remainder for 3&4 added together 	
	
	la $a0, prompt		# Load address of prompt for syscall
	li $v0, 4		# Specify print string service
	syscall			# Print prompt
	li $v0, 5		# Specify read integer service
	syscall			# Read number and load into $v0
	addi $t0, $v0, 0 	# Transfer prompt number to $t0 register
	
	init:
		li $t3, 3 	# Register stores 3 for REM op
		li $t4, 4	# Register stores 4 for REM op
		li $t1, 1	# Counter Register to Prompt number
		addi $t0, $t0, 1 	# Add 1 to prompt so loop can execute to prompt number
	loop_start:
		beq $t1, $t0, loop_end 	# If($t1 == $t0) -> Counter == Prompt number
	loop_body:
		rem $t2, $t1, $t3	# Divide prompt number / 3 and store remainder in $t2 -> 0 if divisible
		rem $t5, $t1, $t4  	# Divide prompt number / 4 and store remainder in $t5 -> 0 if divisible
		add $t6, $t2, $t5	# Store remainder of $t2 & $t5 to check when number is divisible by both -> 0 if divisible

		beqz $t6, loopFeedBabe	# Print FEEDBABE if divisible by 3 & 4 -> $t6 == 0
		beqz $t2, loopFeed	# Print FEED if divisible by 3 -> $t2 == 0
		beqz $t5, loopBabe	# Print BABE if divisible by 4 -> $t5 == 0
		#bge $t6, 1, loopNumber
		#bnez $t2, loopNumber	# Print number if not divisible by 3
		#bnez $t5, loopNumber	# Print number it not divisible by 4
		#beq $t2, $t5, loopFeedBabe
		
		# If no branches, execute loopNumber
	loopNumber:
		add $a0, $t1, 0		# Store counter number in #a0
		li $v0, 1		# Specify print integer service
		syscall			# Print integer
		li $v0, 4		# Specify print string service
		la $a0, newLine		# Load address of data newLine
		syscall			# Print newLine
		j update		# Branch to update
	loopFeed:
		li $v0, 4		# Specify print string service
		la $a0, FEED		# Load "FEED"
		syscall			# Print FEED
		li $v0, 4		# Specify print string service
		la $a0, newLine 	# Load newLine
		syscall			# Print newLine
		j update		# Branch to update
	loopBabe:
		li $v0, 4		# Specify print string service
		la $a0, BABE		# Load "BABE"
		syscall			# Print BABE
		li $v0, 4		# Specify print string service
		la $a0, newLine 	# Load newLine
		syscall			# Print newLine
		j update		# Branch to update
	loopFeedBabe:
		li $v0, 4		# Specify print string service
		la $a0, FEEDBABE	# Load "FEEDBABE"
		syscall			# Print FEEDBABE
		li $v0, 4		# Specify print string service
		la $a0, newLine 	# Load newLine
		syscall			# Print newLine
		j update		# Branch to update
	update:
		addi $t1, $t1, 1	# Update counter by +1
		b loop_start		# Branch back to start
	loop_end:
		nop			# No operation
	
	# End program
	li $v0, 10
	syscall

#Strings for prompt and words to be printed	
.data
prompt: 
.asciiz "Please input a number: " 
FEED:
.asciiz "FEED"
BABE:
.asciiz "BABE"
FEEDBABE:
.asciiz "FEEDBABE"
newLine:
.asciiz "\n"
