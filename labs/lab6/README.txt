--------------------------------
LAB 6: FLOATING POINT MATH
CMPE 012 Spring 2018

Kang Jie Tan, ktan18
Section 01F, Mike
--------------------------------


----------------
LEARNING

<<Describe what you learned, what was surprising, what worked well and what did not.>>
In this lab, I learned how to write subroutines that can be called on which also could call
upon other functions. This leads to first calling function having to store the return address it
currently has because when it calls another function the return address register will be overwritten.
What was surprising is how you can just shift things around in the register to get what you want. You
can't access the bits directly but you can work things around with shifts. What worked well is the first 
two functions, PrintFloat and CompareFloats. I had no trouble writing them at all. What did not work well 
is the last 3 functions. For AddFloats, I tried to normalize the number inside the function itself. Things 
did not go on as planned so I went to MultFloats and NormalizeFloat but I struggled with that as well.

----------------
ANSWERS TO QUESTIONS

1.
<<I did not write additional test code. I only changed the inputs of A and B test to check
if the subroutines worked for other inputs.>>

2.
<<Floating point overflow is when a arithmetic operation is done on two floating point numbers
and in the exponent or mantissa, a number can't be represented by the actual 8 bits in the exponent or 23 bits 
in the mantissa if it were a 32-bit number. An example with mantissa addition would be 1.1000 + 1.1000 which 
results to 11.0000. The 1 in the mantissa overflowed to the leading one's place.>>

3.
<<I was not able to get the issue of rounding.>>

4.
<<I did not write any additional functions.>>
