# Notes
# Enter "user input" into program arguments. $a1 contains the address of a location
# in data memory which contains the address of the string. Store contents of $a1 in a $t1
# Load byte from the address in $t1. Check if the byte is a digit or letter.
# If char is digit, subtract 48 to get ascii representation of it in hex or 55 if it is
# a letter. Each char is 4 bits (binary). Store the first char by shifting left 28 bits
# (32-4 = 28 bits). Use bitwise OR to put bits into $s0 in the right order. Next char is stored 
# 32-4-4 = 24 bits and so on.

 # PSEUDOCODE
 # Read in program arguments
 # Store contents of $a1 into register
 # Load byte from address in $a1
 # Determine if char is a digit or letter
 # Store char by using OR 
 # Shift first byte by 28
 # Update counter by 1 and decrease shift position by 4
 # Start back at store
 # Determine if $s0 is negative
 # If negative then invert and add 1 (2'S C)
 # Use REM(10) on $s0 to get last digit
 # Store into array with allocated space
 # Divide $s0 by 10 to move onto next digit
 # Repeat REM, store, and DIV until $s0 is 0
 # Use REM(10) on array to find number of digits
 # Load byte from array and print it
 # Update digit counter and position in array by -1
 # Repeat until digit counter hits 1
 
.text
init:
	lw $t0, ($a1) 	# Address of the string for program arguments
	li $t2, 48	# Constant to subtract for digit
	li $t3, 55	# Constant to subtract for letter
	li $t4, 28	# Constant for determining position of hex bit in $s0
	li $t5, 10	# Constant for REM to get digits from $0
	la $a0, prompt	# Print prompt
	li $v0, 4
	syscall
	
start: # Exits when a null character is loaded. Body #1 for loading storing program argument into $s0
	lb $t1, 2($t0)		# Load byte from address of string that contains program argument
	move $a0, $t1
	bgt $t1, 64, letter 	# Branch if char is a letter
	beq $t1, 0, start2	# Checking for null character to exit loop. Branch to Body #2.
	
	digit: # When char is a digit 0--9
		li $v0, 11		# Print char
		syscall
		sub $t1, $t1, $t2	# Subtract 48 to get digit
		sllv $t1, $t1, $t4	# Shift bits by 28 and decrease by increments of 4. Position to be stored in $s0
		or $s0, $s0, $t1	# OR loaded bits with $s0 to store into it. $s0(0000) OR $t1(1010) = $s0(1010)
		b update
		
	letter: # When char is a letter A-F
		li $v0, 11		# Print char 
		syscall
		sub $t1, $t1, $t3	# Subtract 55 to get letter
		sllv $t1, $t1, $t4	# Shift bits by 28 and decrease by increments of 4. Position to be stored in $s0
		or $s0, $s0, $t1	# OR loaded bits with $s0 to store into it. $s0(0000) OR $t1(1010) = $s0(1010)
		
	update: # Updating counter for addressing string and position of hex bit
		addi $t0, $t0, 1	# Increasing loop for loading byte from program arguments
		addi $t4, $t4, -4	# Decrease each position of byte to be stored in $s0
		b start
	
start2: # Body #2 for converting number into chars and storing it in array
	la $t7, array		# Load array with allocated space
	la $a0, newLine		# Print newline
	li $v0, 4
	syscall
	la $a0, decimal		# Print decimal string
	li $v0, 4
	syscall
	bltz $s0, negative	# Check if stored number is negative
	
	store: # Exits when $s0 is divided by 10 in a loop down to 0.
		beqz $s0, printd	# Branch when $s0 is 0 after division by 10
		rem $t6, $s0, $t5
		add $t6, $t6, 48	# Convert number to ASCII(char)
		sb $t6, ($t7)		# Stored ASCII(char) into array
		add $t7, $t7, 1		# Increase position of array by 1(char)
		
	div10:
		div $s0, $s0, 10	# Divide stored number by 10
		b store
		
		negative:
			la $a0, minus		# Load minus sign
			li $v0, 4		# Print minus sign
			syscall
			not $s0, $s0		# Performing 2'S C if number is negative. Invert
			addi $s0, $s0, 1	# Then add one to it
			b store			# Branch to store
	
printd: # Body #3 for printing array
	rem $t9, $t7, $t5	# Determine number of digits to be printed
	
	printarray: # Exits when digit counter is decreased to 1
		lb $t2, -1($t7)		# Load byte from array. Offset -1 to account for missing negative sign. Sign is not in array
		move $a0, $t2
		li $v0, 11		# Print char
		syscall
		beq $t9, 1, endp	# End program when digit counter is 1
		
	update1:
		addi $t9, $t9, -1	# Counter for number of digits to be printed
		addi $t7, $t7, -1	# Going in reverse order the chars were stored
		b printarray
		
endp: # End program
	li $v0, 10
	syscall

#Strings and array to be printed
.data
	prompt:
	.asciiz "Input a hex number:\n0x"
	decimal:
	.asciiz "The decimal value is:\n"
	newLine:
	.asciiz "\n"
	array:				# Where the number of $s0 is stored in ASCII
	.space 32
	minus:
	.asciiz "-"
