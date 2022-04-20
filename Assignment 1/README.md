Assignment 1
============

**Due**: March 1st, 2021

To Do:
------

1. [x] (1.5 pts) Recognize programming arithmetic operators. 
  - [x] 1/2
    * `\+`
    * `\-`
    * `\*`
    * `/`
    * `+=`
    * `++`
  - [x] 2/2
    * `<=`
    * `\>=`
    * `==`
    * `~=`
    * `<`
    * `\>`


2. [x] (2 pts) Modify T_ID rule to recognize identifiers that follow these rules:

  * First character is `@`.
  * Second character **must** be a letter.
  * Remaining Characters can be any _case-insensitive_ letter, digit, or underscore symbol.

3. [x]  (2.5 pts) Recognize floating points using a rule that returns a L_FLOAT token such that:

  * Number either has `+` or `-` or neither.
  * Integer and fractional values are separated by `.`.
  * Both integer and fractional values have at least one digit:
    - `<Integer>.<Fractional>`

4. [x] (1.5 pts) Create rules to recognize these keywords and replace with correspontind token from tokens.h (`K_<keyword>`)
  - [x] 1/2
    * `integer`
    * `float`
    * `foreach`
    * `begin`
    * `end`
    * `repeat`
  - [x] 2/2
    * `until`
    * `while`
    * `declare`
    * `if`
    * `then`
    * `print`

### Work Distribution

Nima:
- Problem 1.

Armon:
- Problem 3 and 1/2 of 4.

Jose:
- Problem 2 and 2/2 of 4.

### Important Notes

- Do not change Driver file nor tokens.h files.


Addenda
-------

* Due date moved from February 26th to **March 1st.**

* Added Input and Output testing data.

* line 60 in pl-scanner.yy update

* Update on driver.cc



[More](./cs3323-a1.pdf)


CS 3323 -- The University of Oklahoma -- Spring 2021.