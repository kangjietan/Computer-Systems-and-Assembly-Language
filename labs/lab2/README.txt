README
Kang Jie Tan
ktan18@ucsc.edu
1480498
Lab 2 Intro to MML
Due: 4/20/18 11:59pm
Section 01F 3-4pm Mike

For part B, I learned how to display 0-15 from binary to hexadecimal on the 7-segment display with the 4 switches. 
When only one switch is on, the switch that is connected the 0th place on the display would output a 1 when the 
switch is on, 1st place would output a 2, 2nd place would output a 4, and 3rd place would output an 8.

For part C, I learned how to design logic that implements the given truth table. 
Looking at the truth table, 0s appeared the least in the output so I decided to use Product of Sums. 
I wrote down the down the inputs and then inverted them. 
I was satisfied when I went through each of the table inputs and it produced the right output.

Part D, I learned how to design logic that would allow the user to guess the output of the random number generator. 
The hint about the logical AND gate helped me to think of the gates to use with the output of the RNG and switch. 
For a 3-input AND gate, only 1 1 1 would output a 1 so from there I knew that the RNG output and user guess must 
output a 1 if they matched. With that in mind, I looked at the truth tables for the logical gates and the XNOR gate 
matched what I wanted. If the RNG output and switch didn't match then there is an output of 0 and the LED wouldn't 
turn on. At the start of building this design, I struggled a little until I read the hint. 
It helped me to write out the truth table and find the appropriate logic gate. 

1)How would you make your own 7-segment display from Part B if you didn’t have one in MML?

To make my own 7-segment display, I would use the LEDs to create the display. 
I would just replace each line on the 7-segment display with one of the LED blocks to recreate it. 
Would also have to figure out the logic for that.

2)How do you think the random number generator works?

I think the random number generator is given a random seed each time the button is pressed 
and that seed generates output based on the seed. The same random seed will always produce the same output. 
The seed doesn't generate a random output.

3)How can things be really random in a computer when it is made of logic gates, which are supposed to be 
deterministic?

I think the user has to input something that seems random to them but to the computer that input already is 
predetermined. It implements some kind of way to make things seem like it is random but I don't know what that is.