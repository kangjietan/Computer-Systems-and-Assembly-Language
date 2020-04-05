--------------------------------
LAB 5: HEX TO DECIMAL CONVERSION
CMPE 012 Spring 2018

Kang Jie Tan, ktan18
Section 01F, Mike
--------------------------------


----------------
LEARNING

<<Describe what you learned, what was surprising, what worked well and what did not.>>
In this lab, I learned how to take an ASCII string as a program input and convert each
char in the string to hex values so it could show up in the register. Also learned how to 
look through addresses in the data segment to find where data was stored. In the beginning, I 
was really how confused to do part #2 of the lab. I thought we had to convert the program 
argument bit by bit (ex. F to 1111, one bit at a time). But after going to lab, I realized 
everything was in 1s and 0s and the hex values were just another way to represent those 1s and 0s. 
I had no problem shifting the bits into the right place to be stored into $s0. Another problem I had
was figuring out how to store the number as ASCII chars into an array. The slides that the TA Carlos 
provided really helped out. The problem I spent the most time on was printing the array. When I printed 
the string that contained the number, everything was in reverse order. This one took me some time. Overall,
I was most surprised about the process of storing the program arguments into a register. Seeing it work was
really satisfying.

----------------
ANSWERS TO QUESTIONS

1.
<<There is only 1 representation of 0 for the input number.>>

2.
<<The largest input value that the program supports is 0x7FFFFFFF(2147483647).>>

3.
<<The smallest input value is 0x80000000(-2147483648).>>

4.
<<In signed arithmetic there is overflow but not in unsigned. In my program, I used
signed arithmetic. Signed arithmetic had to be used since the number stored is in
2’S C. Disadvantages are special cases like 0x8000000 where there is overflow and the
program stops/crashes.>>

5.
<<The process/code would be pretty similar as what I wrote for this lab. Instead of
dealing with 4 bits now, I would be dealing with 1 bit. I would load the the program
arguments the same. Now I wouldn't have to shift by 4 bits now but by 1 and then I can
store it the same way. Essentially the same program but changing the things that deal
with 4 bits to make it deal with 1 bit instead.>>
