--------------------------------
LAB 3: LOGIC UNIT WITH MEMORY
CMPE 012 Spring 2018

Kang Jie Tan, ktan18
Section 01F, Mike
--------------------------------


----------------
LEARNING

<<Describe what you learned, what was surprising, what worked well and what did not.>>
I learned how to build a multiplexer out of logic gates to select which operation was to 
be performed and store the operation output into a register. The operation that was to be selected
depended on the two values from the MSBsel and LSBsel switches. What was surprising to me was
how you're able to build the MUX with a minimal amount of logic. What was also surprising was 
how the flip flop stores the value and how you're able to take what's stored in the register
and operate on them with bit-wise operations to change them. I was able to build the operations
easily since you were only operating on the keypad bits, register bits, or both. What did not work
well was trying to figure out what I needed to build without a diagram. A visual representation of
the whole logic unit made everything 100% more clear. Going to lab sections really helped tremendously 
since the TAs and tutors explained the lab assignment very well. Things went smoothly after that.
----------------
ISSUES

<<Discuss issues you had building the circuit.>>
What I struggled with was the operations and the MUX especially. In the beginning
I thought that the operations were supposed to output 1 bit only in the end (ex. 
ANDing 4 bits from the keypad and 4 from the register to 1 bit. In other words, 8
bit input and 1 bit output). I thought this way because I didn't read clearly that
we were going to build four 1-bit MUXes. It made me think that we were going to have 
one MUX so the operations should each only output 1 bit. After going to lab, it 
helped clear my confusion on the MUX and I was able to start building it following
the diagram that the TA drew in lab section. 
----------------
DEBUGGING

<<Describe what you added to each module to make debugging easier.>>
In the beginning, I put the keypad inputs into the register to see if the
flip flop was actually storing the bit and displaying it in the 7 segment display. 
After that, I changed the inputs to the MUX bits knowing that the flip flop works.
----------------
QUESTIONS

What is the difference between a bit-wise and reduction logic operation?
<<A bit-wise operation is something like AND & OR. You're operating on bits. When 
you AND 4 bits together with 4 other bits, you'll get back 4 bits. Reduction logic 
operation is reducing the number of logic gates like AND/OR, the number of inputs, or
both.>>

What operations did we implement?
<<We implemented the operations STORE, AND, OR, and INVERT. STORE puts the keypad
inputs into the register. AND & OR operates on the keypad and register bits. NOT
inverts all the bits in the register.>>

Why might we want to use the other type of logic operations?
<<Other types of logic operations may be more efficient than the one we have right
now. For instance instead of having 3 inputs go through an inverter and then an 
AND gate, we could just have the inputs go through an NAND gate instead.>>