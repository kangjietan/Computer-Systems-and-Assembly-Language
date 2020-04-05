--------------------------------
LAB 4: FEEDBABE IN MIPS
CMPE 012 Spring 2018

Kang Jie Tan, ktan18
Section 01F, Mike
--------------------------------


----------------
LEARNING 

<<Describe what you learned, what was surprising, what worked well and what did not.>>
In this lab, I learned some real assembly instructions as well as pseudo ones. I learned which 
registers to use such as v is used to specify which syscall function is to be called and a is used
to store the arguments for the function call. What was surprising to me was how long the code is compared
to a couple of lines in Java. While writing the program, I was able to loop through 1 to the given number 
but what I had trouble with was that the print statments stopped 1 integer before the prompt number so I 
fixed that by adding 1 to the prompt number. Another problem was FEEDBABE was not printing. I realized that 
the program was running sequentially so I placed the branching instruction for FEEDBABE as the first one 
in order. 
----------------
ANSWERS TO QUESTIONS

1.
<<I think the program can go on infinitely if there are no resource limitations. But I
think the size of N depends on how much memory is available for use in the program.>>

2.
<<The address of the prompt string is stored at 0x1001000 in values +0, +4, +8, +c, +10, +14>>

3.
<<Pseudo-ops I used in this program are li, la, rem, and beqz. The pseudo-ops use real instructions
in the assembler.
-li $t, C = addiu $t, $zero, C_lo
-la $t, A = lui $t, A_hi
           ori $t, $t, A_lo
-beqz $s, C = beq $s, $zero, C
-rem $d, $s, $t = div $s, $t
                  mfhi $d>>

4.
<<I used 9 registers in writing this program. I think there might be a way for me to write this program
again with possible one less register. I think the other 8 are absolutely necessary. $a0 and $v0 are needed
for syscall. The other 6 are necessary to store values. $t0 for prompt number, $t1 for tracking and printing 
until prompt number, $t2 & $t3 to store the integer 3 and then remainder by divsion of it, the same for 4
with $t4 $ t5. Those are needed to hold in the values. For $t6 there is probably some way I can evaluate
if the number is divisible by both 3 and 4 without using the register to check. I'm thinking of some beq
conditions but can't think of them right now. So that is the only register I think I would get rid of.>>
