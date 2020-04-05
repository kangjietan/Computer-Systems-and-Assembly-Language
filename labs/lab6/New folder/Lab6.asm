# Kang Jie Tan - ktan18@ucsc.edu - Lab 6 Floating Point Math -  Due: 6/8/18 11:59pm - Section:01F/Mike
PrintFloat:
	subi $sp, $sp, 4
	sw $a0, 0($sp)
	move $t0, $a0
	
	msb: # Print the msb of input
		srl $t1, $a0, 31	# Shift right 31 bits so last one remaining is bit 31 = MSB
		la $a0, sign		# Print sign
		li $v0, 4
		syscall
		la $a0, ($t1)		# Print the MSB
		li $v0, 1
		syscall
		la $a0, newLine		# New line
		li $v0, 4
		syscall
	bitexpinit:
		li $t3, 1		# Set exponent counter for bits at 1. Starting at 1 - MSB is subtracted off
		la $a0, exponent	# Print exponent
		li $v0, 4
		syscall
	bitexp:
		beq $t3, 9, bitmaninit	# Counter for number of bits. 1 to 8 = exponent bits
		move $t1, $t0		# Load input which was in $a0
		sllv $t2, $t1, $t3	# Shift left. Counter manber = bit manber
		srl $t4, $t2, 31	# Shift right to get the bit after it is shifted left. 1 bit left.
		la $a0, ($t4)		# Print bit
		li $v0, 1
		syscall
		addi $t3, $t3, 1	# Update exponent bit counter
		b bitexp
	bitmaninit:
		la $a0, newLine		# Print new line
		li $v0, 4
		syscall
		la $a0, mantissa	# Print mantissa
		li $v0, 4
		syscall
		li $t3, 9		# Start counter 9. Subtracts off MSB and exponent 32-9=23=mantissa
	bitman:
		beq $t3, 32, bitdone	# Counter for number of bits. 9 to 32 = exponent bits
		move $t1, $t0
		sllv $t2, $t1, $t3	# t3 number = bit number in exponent
		srl $t4, $t2, 31	# Shift right to get the bit after it is shifted left. 1 bit left.
		la $a0, ($t4)		# Print mantissa bit
		li $v0, 1
		syscall
		addi $t3, $t3, 1	# Update counter for mantissa
		b bitman
	bitdone:
		lw $a0, 0($sp)
		addi $sp, $sp, 4
		jr $ra

CompareFloats:
	subi $sp, $sp, 8
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	move $t0, $a0
	move $t1, $a1
	
	msbcheck:
		srl $t2, $a0, 31	# MSB of a0
		srl $t4, $a1, 31	# MSB of a1
		bgt $t2, $t4, altb	# If t2 is 1 and t4 is 0. t2 is negative so less than t4
		beq $t2, $t4, aeb	# If t2 and t4 = 0 or 1
		blt $t2, $t4, agtb	# If t2 is 0 and t4 is 1. t2 is positive so greater than t4
	
		agtb: # A>B
			li $v0, 1
			b floatdone		# Finished. A is positive. B is negative
		aeb: # A=B
			b expcheckinit		# Check exponent now since MSB is the same
		altb: # A < B
			li $v0, -1
			b floatdone		# Finished. A is negative. B is postive
	
	expcheckinit:
		move $a0, $t0
		move $a1, $t1
	expcheck: # If signs equal each other
		sll $t2, $a0, 1		# Get rid of MSB
		sll $t4, $a1, 1		# Get rid of MSB
		srl $t3, $t2, 24
		srl $t5, $t4, 24
		bgt $t3, $t5, expagtb		# If A > B
		beq $t3, $t5, expaeb		# If A = B
		blt $t3, $t5, expaltb		# If A < B
		
		expagtb:
			li $v0, 1
			b floatdone		# Finished. A > B. Larger number in exponent
		expaeb:
			b mancheckinit		# Check mantissa now since exponent is the same
		expaltb:
			li $v0, -1
			b floatdone		# Finished. A < B. Smaller number in exponent
			
	mancheckinit:
		move $a0, $t0
		move $a1, $t1
	mancheck: # If sign and exponent equals each other
		sll $t2, $a0, 9
		sll $t4, $a1, 9
		bgt $t2, $t4, managtb		# If A > B
		beq $t2, $t4, manaeb		# If A = B
		blt $t2, $t4, manaltb		# If A < B
		
		managtb:
			li $v0, 1		# Finished. A>B. Larger number in mantissa.
			b floatdone
		manaeb:
			li $v0, 0		# Finished. A = B. Same mantissa
			b floatdone
		manaltb:
			li $v0, -1		# Finished. A < B. smaller number in mantissa.
			
	floatdone:
		lw $a0, 4($sp)
		lw $a1, 0($sp)
		addi $sp, $sp, 8
		jr $ra
		
AddFloats:
	subi $sp, $sp, 8
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	move $t0, $a0
	move $t1, $a1
	
	addmsbcheck:
		srl $t2, $a0, 31	# MSB in a0
		srl $t4, $a1, 31	# MSB in a1
		bgt $t2, $t4, negpluspos	# -A + B 
		beq $t2, $t4, samesign		# If both manbers are the same sign
		blt $t2, $t4, posplusneg	# A + -B
		
		samesign: # Exponent check
			sll $v0, $t2, 31	# Shift bit back to sign place and store sign into $v0
			move $a0, $t0
			move $a1, $t1
			sll $t2, $a0, 1		# Get rid of MSB
			sll $t4, $a1, 1		# Get rid of MSB
			srl $t3, $t2, 24
			srl $t5, $t4, 24
			bgt $t3, $t5, addexpagtb	# A's exponent > B's
			beq $t3, $t5, addsameexp	# A = B in exponent
			blt $t3, $t5, addexpaltb	# A's exponent < B's
			
			addsameexp: # A = B in sign and exponent
				sll $t6, $t3, 23		# Shift bits back to exponent place and store it in v0
				or $v0, $v0, $t6
				move $a0, $t0
				move $a1, $t1
				sll $t2, $a0, 9			# Mantissa bits in a0
				sll $t4, $a1, 9			# Mantissa bits in a1
				bgt $t2, $t4, addmanagtb	# A > B in mantissa
				beq $t2, $t4, addsameman	# A = B in mantissa
				blt $t2, $t4, addmanaltb	# A < B in mantissa
				
				 	addsameman:
				 		srl $t5, $t2, 9			# Shift bits to back to mantissa position
				 		ori $t6, $t5, 0x00800000	# Mask that places the leading one in front of mantissa
				 		or $v0, $v0, $t6		# Store mantissa in with sign and exp
				 		b addfinish
				 	addmanagtb:
				 		srl $t5, $t2, 9			# Shift bits to back to mantissa position
				 		srl $t6, $t4, 9			# Shift bits to back to mantissa position
				 		ori $t7, $t5, 0x00800000	# Mask that places the leading one in front of mantissa
				 		ori $t8, $t6, 0x00800000	# Mask that places the leading one in front of mantissa
				 		add $t9, $t7, $t8		# Add the two mantissas
				 		srl $t9, $t9, 1			# Shift back to 24 bits from leading one overflow
				 		or $v0, $v0, $t9		# Store mantissa in with sign and exp
				 		b addfinish
				 	addmanaltb:
				 		srl $t5, $t2, 9			# Shift bits to back to mantissa position
				 		srl $t6, $t4, 9			# Shift bits to back to mantissa position
				 		ori $t7, $t5, 0x00800000	# Mask that places the leading one in front of mantissa
				 		ori $t8, $t6, 0x00800000	# Mask that places the leading one in front of mantissa
				 		add $t9, $t7, $t8		# Add the two mantissas
				 		srl $t9, $t9, 1			# Shift back to 24 bits from leading one addition overflow
				 		or $v0, $v0, $t9		# Store mantissa in with sign and exp
				 		b addfinish
			addexpagtb: # A > B in exponent
				sub $t6, $t3, $t5		# A - B in exponent
				sll $t7, $t3, 23		# Shift bits back to exponent place and store it in v0
				or $v0, $v0, $t7		# Store exponent into v0
				move $a0, $t0
				move $a1, $t1
				sll $t2, $a0, 9			# Mantissa bits in a0
				sll $t4, $a1, 9			# Mantissa bits in a1
				sllv $t8, $t4, $t6		# Shift B mantissa bits by exponent difference
				ori $t7, $t2, 0x00800000	# Mask that places the leading one in front of mantissa
				ori $t9, $t8, 0x00800000	# Mask that places the leading one in front of mantissa
				sllv $t9, $t9, $t6
				add $t3, $t7, $t9		# Add the two mantissas
				div $t6, $t6, 1
				srlv $t3, $t3, $t6		# Shift back to 24 bits from leading one addition overflow
				or $v0, $v0, $t3		# Store mantissa in with sign and exp
				b addfinish
			addexpaltb: # A < B in exponent
				sub $t6, $t5, $t3		# A - B in exponent
				sll $t7, $t5, 23		# Shift bits back to exponent place and store it in v0
				or $v0, $v0, $t7		# Store exponent into v0
				move $a0, $t0
				move $a1, $t1
				sll $t2, $a0, 9			# Mantissa bits in a0
				sll $t4, $a1, 9			# Mantissa bits in a1
				sllv $t8, $t2, $t6		# Shift mantissa bits by exponent difference
				ori $t7, $t2, 0x00800000	# Mask that places the leading one in front of mantissa
				ori $t9, $t8, 0x00800000	# Mask that places the leading one in front of mantissa
				add $t3, $t7, $t8		# Add the two mantissas
				srl $t3, $t3, 1			# Shift back to 24 bits from leading one addition overflow
				or $v0, $v0, $t3		# Store mantissa in with sign and exp
				b addfinish
		negpluspos: # -A + B
			
		posplusneg: # A + -B
		
	addfinish:
	lw $a0, 4($sp)
	lw $a1, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	
MultFloats:
	subi $sp, $sp, 8
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	move $t0, $a0
	move $t1, $a1
	
	signbit:
		srl $t2, $a0, 31		# MSB in a0
		srl $t3, $a1, 31		# MSB in a1
		beq $t2, $t3, positive		# -1 * -1 = pos
		bgt $t2, $t3, negative		# A = 1
		blt $t2, $t3, negative		# B = 1
	
		negative:
			li $a0, 1
			b mantissamath
		positive:
			li $a0, 0
			b mantissamath
			
	mantissamath:
		move $t2, $t0
		move $t3, $t1
		sll $t2, $t2, 9		# Get rid of MSB
		sll $t3, $t3, 9		# Get rid of MSB
		mult $t2, $t3
		mfhi $a1
		mflo $a2
NormalizeFloat:
	
.data
	sign: 
	.asciiz "SIGN: "
	exponent:
	.asciiz "EXPONENT: "
	mantissa:
	.asciiz "MANTISSA: "
	newLine:
	.asciiz "\n"