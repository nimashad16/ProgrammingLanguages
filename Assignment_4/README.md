
Assignment 4
=============

Before working on this, look over `icode.cc` lines 326-457 to get a grasp over the new operations we will be working with.


To Do
------

1. `gramar.y`
  - Implement __repeat-until__. Use _OP\_JZ_. [Read](./cs3323-SP21-a4.pdf) documentation for more. 
  - Replace _DEFINE\_ME_ at lines 153-167. `construct\_while` will help.

2. `gramar.y`
  - Complete `TBD\_ARG` on lines 239, 241, and 264. `itab\_instruction\_add` is super helpful. See arr0\[1-3\] and "bubble-sort" test cases for more information. [Read](./cs3323-SP21-a4.pdf) documentation for more. 

3. `gramar.y`
  - Implement if-then and if-then-else using 3 semantic actions on lines 171-194:
    1. jump to false-branch if condition is false.
    2. generate unconditional jump to skip else-branch and complete jump's destination as by first ation.
    3. set jump address from second action.
  - [Read](./cs3323-SP21-a4.pdf) documentation for more. 


### Some extra notes

I found it incredibly useful the slides on P6-ControlFlow.pdf. Take a look at those slides from canvas. Pg. 7 has information about how to use OP_JZ, etc. Also, Lecture from April 19, **21**, **23**, 26 are incredibly helpful. He explains very indepth some of the things we have to do here.



Work Assignments
-----------------

* Nima
  - TBD

* Armon
  - TBD

* Jose
  - Problem 3