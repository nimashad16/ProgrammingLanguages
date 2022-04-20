%language "c"
%skeleton "glr.c" 
%require "3.0.2"
%verbose
%defines 
%locations

%code
{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void yyerror (char const *);
extern int yylex ();
extern char * yytext;
}

%token T_ID
%token T_NUM
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_LT
%token T_GT
%token T_LEQ
%token T_GEQ
%token T_EQ
%token T_NEQ
%token T_AND
%token T_OR
%token T_READ
%token T_WRITE
%token T_ASSIGN
%token T_BEGIN
%token T_END
%token T_FOREACH
%token T_IN
%token T_REPEAT
%token T_UNTIL
%token T_WHILE
%token T_IF
%token T_THEN
%token T_ELSE
%token T_DECLARE
%token T_INTEGER
%token T_FLOAT
%token T_LITERAL_STR



%%

program : stmt_list ';' ;

stmt_list : stmt_list ';' stmt
    | stmt
    ;

stmt : assignment
    | read 
    | write
    | while
    | repeat
    | block
    | foreach
    | if_stmt
    ;

block : T_BEGIN stmt_list T_END
  ;

foreach : T_FOREACH T_ID T_IN '(' a_expr ':' T_ID ')'  
          stmt
    ;

while : T_WHILE l_expr stmt
    ;

repeat : T_REPEAT stmt_list T_UNTIL l_expr
  ;

if_stmt : T_IF
          l_expr
          T_THEN
          stmt
          else_stmt
  ;

else_stmt : T_ELSE
            stmt
  |         
  ;

assignment : varref T_ASSIGN l_expr ;

a_expr : a_expr T_ADD a_term 
    | a_expr T_SUB a_term
    | a_term
    ;

a_term : a_term T_MUL a_fact
    | a_term T_DIV a_fact
    | a_fact
    ;

a_fact : varref
    | T_NUM
    | T_LITERAL_STR
    | T_SUB a_fact
    | '(' a_expr ')'
    ;

varref : T_ID
  | varref '[' a_expr ']'
  ;

l_expr : l_expr T_AND l_term
  | l_term
  ;

l_term : l_term T_OR l_fact
  | l_fact
  ;

l_fact : l_fact oprel a_expr
  | a_expr
  | '(' l_expr ')'
  ;


oprel : T_LT
  | T_GT
  | T_LEQ
  | T_GEQ
  | T_EQ
  | T_NEQ
  ;


read : T_READ varlist ;

write: T_WRITE expr_list;

varlist : varref ',' varref
      | varref
      ;

expr_list : a_expr ',' a_expr
  | a_expr
  ;

%%

//void yyerror (YYLTYPE * loc, char const * msg)
void yyerror (char const * msg)
{
  #ifndef PL_GRADER
  printf ("Found error: %s (line %d, column %d)\n",
    yytext, yylloc.last_line, yylloc.last_column);
  #endif
}
