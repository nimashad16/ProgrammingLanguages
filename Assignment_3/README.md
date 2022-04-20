
Assignment 3
============

The goal is to create a basic functional compiles that can compile with arithmetic operations.

Due: **April 19th** by 11:59pm

Files to modify: _grammar.y_ and _icode.cc_.

To Do
-----

1. (2.5pt) In **grammar.y**, complete the semantic actions corresponding to the floating point arithmetic
binary operations of the non-terminals a expr and a term: (OP FADD, OP FSUB, OP FMUL and
OP FDIV). You should *query the datatype* field of a temporary symbol to determine the correct
operation to be generated.

2. (1.0pt) In **icode.cc**, function **run**, implement the run-time actions for the *floating point arithmetic*
binary operations OP FADD, OP FSUB, OP FMUL and OP FDIV. These four operations are specific
to the datatype **DTYPE FLOAT**.


3. (1.0pt) In **icode.cc**, function **run**, complete the run-time action of the *floating point arithmetic unary*
operation **OP UMIN for the DTYPE FLOAT** datatype (float). The current implementation only
supports *DTYPE INT* (a C/C++ int).


4. (1.0pt) In **icode.cc**, function **run**, complete the run-time action of the *operation OP STORE* for the
datatype **DTYPE FLOAT**. It should be very similar to the *DTYPE INT* case.


5. (1.0pt) In **icode.cc**, function **run**, complete the run-time action of the *operation OP LOAD* for the
datatype **DTYPE FLOAT**. It should be very similar to the *DTYPE INT* case.


6. (1.0pt) In **icode.cc**, function **run**, complete the run-time action of the *operation OP LOAD CST* for
the datatype **DTYPE FLOAT**. It should be very similar to the *DTYPE INT* case.


Work Assignment
---------------

Jose
- 1, 2

Nima
- TBA

Armon
- TBA