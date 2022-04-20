
Assignment 2
============

For this assignment, we will create a fully functional parser.


Assignment Structure
--------------------

The assignments provides us with:

* [A scanner](scanner.yy)
  - Similar to Assignment 1. **Do not change**
* [A parser](grammar.y)
  - Contains the grammar rules for the parser. **Will be the focuss of the assignment**
* [A driver program](driver.c)
  - Helps in creating the final executable. **Do not change**
* [A makefile script](Makefile)
  - Helps in building the project for testing. **See instructions for Mac users**
* [Instructions](cs3323-a2)
  - Duh, instructions. Jose Highlighted some of the important stuff.
* [A directory of example code and test inputs](inputs/)
  - Super important to better understand the code. This folder contains the code for which we shall be parsing for. Notice the convention: 
    * ``` regex 
    aspect (expr|for|if|read|repeat|while|write)
    DIGIT  [0-9]
    {aspect}{DIGIT}_(pass|fail).smp
    ``` 
    which its also:
    ``` regex
    (expr|for|if|read|repeat|while|write)[0-9]_(pass|fail).smp
    ```
    * Each file contains the code that tests for each aspect (for, repeat, etc) and gives us whether the parser should accept the input program (pass or fail).


Assignment To Do
----------------

1. (0.5pt) Complete **varlist** (lines 143-145) non-terminal production. It should produce a comma-separated list of variable references __varref__ where the list should be of _at least_ length one. This production is used by **read** (line 139). See _read_ test files.

2. (0.5pt) Complete **expr_list** (lines 147-149) non-terminal production. It shall produce a comma-separated list of arithmetic expressions. see a_expr in lines 95-98 for more on this. The list of arithmetic expressions should be of at least length one. See _write_ test files.

3. (1.5pt) Define 3 productions for non-terminal **l_fact** (lines 124-126). See _if_ test files. There is no examples using _and_ tokens though.
    1. Left recursive rule
        * Shall produce comparisons of arithmetic expressions with **a_expr**. 
        * Shall use **oprel**
    2. Single arithmetic expression
        * **a_expr**
    3. Logical expression in parenthesis
        * Using **l_expr**.

4. (1pt) Define two productions for **varref** non-terminal that match the following: (See _expr_ test files)
    * Variable reference can be **T_ID** token.
    * Variable reference can be left-recursive list of arithmetic expressions surrounded by \[ \] that terminates with **T_ID**.

5. (2pt) Define 5 productions for **a_fact** (lines 105-109). See _expr_, _if_, _while_, and _for_ test files.
    1. **a_fact** can be **varref** (variable reference)
    2. Token **T_NUM**
    3. Literal String **T_LITERAL_STR**
    4. non-terminal a_fact preceded by **T_SUB** token. Avoid using '-'
    5. Parenthesized arithmetic expression **a_expr**

6. (2pt) Complete 4 control-flow constructs **l_expr** is to be used for representing logical expressions. (Lines 74-91). See _if_, _while_, _for_, and _repeat_ test files.

    1. foreach
        * Complete the production
    2. repeat-until
        * Using **stmt_list**, define repeat-until as a list of statements delimited by tokens **T_REPEAT** and **T_UNTIL**. The controlling condition shall use **l_expr**.
    3. while
        * **T_WHILE** followed by a logical expression (**l_expr**)
    4. if-then/if-then-else
        * **T_IF** token followed by logical expression (**l_expr**). True branch shall be preceded by **T_THEN** token; the  false branch shall be **T_ELSE** followed by a statement or _nothing_.


Work Assignment
---------------

Nima: 3, 4
Armon: 2, 6
Jose: 1, 5

Adenda
------

