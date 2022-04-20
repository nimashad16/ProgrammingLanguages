%language "c++"
%skeleton "lalr1.cc" /* -*- C++ -*- */
%require "3.0.2"
%verbose
%locations
%defines
%define api.token.constructor
%define api.value.type variant
%define parse.assert true
%define parser_class_name {simple_parser}
%define parse.trace true
%define parse.error verbose
%parse-param {symtab_t * symtab}
%parse-param {itab_t * itab}
%parse-param {char * static_mem}

%code requires {

#include "icode.hh"
#include "symtab.hh"
}


%code
{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "icode.hh"
#include "symtab.hh"

using namespace std;
extern yy::simple_parser::symbol_type yylex(); 
extern char * yytext;
static int stptr = 0;

extern yy::location loc;

#define _SMP_DEBUG_

}

%token T_EOF 0
%token T_NUM
%token T_ASSIGN
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_DT_INT
%token T_DT_FLOAT
%token T_LITERAL_STR
%token T_READ
%token T_WRITE
%token T_SEMICOLON
%token T_COMMA

%token <string>		T_ID ;
%token <int>		T_INTEGER ;
%token <float>		T_FLOAT;

%type <symbol_t*> assignment;
%type <symbol_t*> varref;
%type <symbol_t*> a_expr;
%type <symbol_t*> a_term;
%type <symbol_t*> a_fact;
%type <int> declaration;
%type <int> datatype;
%type <vector<symbol_t*> > varlist;
%type <vector<symbol_t*> > expr_list;

%%

program : stmt_list T_SEMICOLON 
  ;

stmt_list : stmt_list T_SEMICOLON stmt
    | stmt
    ;

stmt : assignment
    | read 
    | write
    | declaration
    ;

assignment : varref T_ASSIGN a_expr 
      {
        itab_instruction_add (itab, OP_STORE, $1->addr, $1->datatype, $3->addr);
        $$ = $1;
      }
    ;

declaration: datatype T_ID { 
      assert (symtab);
      assert (itab);
      symbol_t * sym = symbol_create (symtab, $2, $1); 
      assert (sym);
      symbol_add (symtab, sym);
    }
    ;

datatype : T_DT_INT { $$ = DTYPE_INT; }
    | T_DT_FLOAT { $$ = DTYPE_FLOAT; }
    ;

a_expr : a_expr T_ADD a_term 
      {
        if ($1->datatype != $3->datatype)
        {
          cout << "Incompatible datatypes\n";
          exit (1);
        }
        symbol_t * res;
        if ($1->datatype == DTYPE_INT)
        {
          res = make_temp (symtab, $1->datatype);
          itab_instruction_add (itab, OP_ADD, res->addr, $1->addr, $3->addr);

        }
        if ($1->datatype == DTYPE_FLOAT)
        {
          res = make_temp (symtab, $1->datatype);
          itab_instruction_add (itab, OP_FADD, res->addr, $1->addr, $3->addr);
        }
        $$ = res;
        #ifdef _SMP_DEBUG_
        cout << "On a_expr (1)\n";
        #endif
      }
    | a_expr T_SUB a_term
      {
        if ($1->datatype != $3->datatype)
        {
          cout << "Incompatible datatypes\n";
          exit (1);
        }
        // TASK: Complete support for OP_SUB and OP_FSUB. See OP_ADD and OP_FADD code above.
        // #2
        symbol_t * res;
        if ($1->datatype == DTYPE_INT)
        {
          res = make_temp (symtab, $1->datatype);
          itab_instruction_add (itab, OP_SUB, res->addr, $1->addr, $3->addr);
        }

        // Float OP_FSUB
        if ($1->datatype == DTYPE_FLOAT)
        {
          // TASK: Modify this semantic action to support both DTYPE_INT and DTYPE_FLOAT.
          // For DTYPE_FLOAT you should generate an OP_FSUB instruction.
          // Querying function #1
          res = make_temp (symtab, $1->datatype);
          itab_instruction_add (itab, OP_FSUB, res->addr, $1->addr, $3->addr);
        }

        $$ = res;
        #ifdef _SMP_DEBUG_
        cout << "On a_expr (2)\n";
        #endif
      }
    | a_term
      {
        $$ = $1;
        #ifdef _SMP_DEBUG_
        cout << "On a_expr (3)\n";
        #endif
      }
    ;

a_term : a_term T_MUL a_fact
      {
        if ($1->datatype != $3->datatype)
        {
          cout << "Incompatible datatypes\n";
          exit (1);
        }
        // TASK: Complete support for OP_MUL and OP_FMUL. See OP_ADD and OP_FADD code above.
        // #3
        symbol_t * res;
        if ($1->datatype == DTYPE_INT)
        {
          res = make_temp (symtab, $1->datatype);
          itab_instruction_add (itab, OP_MUL, res->addr, $1->addr, $3->addr);
        }

        // OP_FMUL
        if ($1->datatype == DTYPE_FLOAT)
        {
          // TASK: Modify this semantic action to support both DTYPE_INT and DTYPE_FLOAT.
          // For DTYPE_FLOAT you should generate an OP_FMUL instruction.
          // Querying function #3
          res = make_temp (symtab, $1->datatype);
          itab_instruction_add (itab, OP_FMUL, res->addr, $1->addr, $3->addr);
        }
        $$ = res;
      }
    | a_term T_DIV a_fact
      {
        if ($1->datatype != $3->datatype)
        {
          cout << "Incompatible datatypes\n";
          exit (1);
        }
        // TASK: Complete support for OP_DIV and OP_FDIV. See OP_ADD and OP_FADD code above.
        // #4
        symbol_t * res;
        if ($1->datatype == DTYPE_INT)
        {
          res = make_temp (symtab, $1->datatype);
          itab_instruction_add (itab, OP_DIV, res->addr, $1->addr, $3->addr);
        }
        if ($1->datatype == DTYPE_FLOAT)
        {
          // TASK: Modify this semantic action to support both DTYPE_INT and DTYPE_FLOAT.
          // For DTYPE_FLOAT you should generate an OP_FDIV instruction.
          // Querying function #4
          res = make_temp (symtab, $1->datatype);
          itab_instruction_add (itab, OP_FDIV, res->addr, $1->addr, $3->addr);
        }
        $$ = res;
        
      }
    | a_fact
      {
        $$ = $1;
        #ifdef _SMP_DEBUG_
        cout << "On a_term (3)\n";
        #endif
      }
    ;

a_fact : varref 
      {
        symbol_t * res;
        assert ($1 && "Did not find variable");
        res = make_temp (symtab, $1->datatype);
        itab_instruction_add (itab, OP_LOAD, res->addr, $1->datatype, $1->addr);
        $$ = res;
      }
    | T_INTEGER 
      {
        symbol_t * res;
        res = make_temp (symtab, DTYPE_INT);
        *(int*)(static_mem+stptr) = $1;
        itab_instruction_add (itab, OP_LOADCST, res->addr, res->datatype, stptr);
        stptr+=4;
        $$ = res;
      }
    | T_FLOAT 
      { 
        symbol_t * res;
        res = make_temp (symtab, DTYPE_FLOAT);
        *(float*)(static_mem+stptr) = $1;
        itab_instruction_add (itab, OP_LOADCST, res->addr, res->datatype, stptr);
        stptr+=4;
        $$ = res;
      }
    | '(' a_expr ')'  { $$ = $2; }
    | T_SUB a_fact
      {
        symbol_t * res;
        res = make_temp (symtab, $2->datatype);
        itab_instruction_add (itab, OP_UMIN, res->addr, $2->datatype, $2->addr);
        $$ = res;
      }
    | T_LITERAL_STR
      {
        $$ = NULL;
      }
    ;

varref : T_ID 
    {
      symbol_t * sym = symbol_find (symtab, $1);
      assert (sym && "Ooops: Did not find variable!");
      $$ = sym;
    }
  ;

read : T_READ varlist 
    {
      vector_itersym_t iter;
      int ii = 0;
      for (iter = $2.begin (); iter != $2.end (); iter++, ii++)
      {
        #ifdef _SMP_DEBUG_
        cout << "Symbol to read (" << ii << "):";
        symbol_show (*iter);
        #endif
        itab_instruction_add (itab, OP_READ, (*iter)->addr, (*iter)->datatype, NOARG);
      }
    }
  ;

write: T_WRITE expr_list
    {
      vector_itersym_t iter;
      int ii = 0;
      for (iter = $2.begin (); iter != $2.end (); iter++, ii++)
      {
        #ifdef _SMP_DEBUG_
        cout << "Symbol to write(" << ii << "):";
        symbol_show (*iter);
        #endif
        itab_instruction_add (itab, OP_WRITE, (*iter)->addr, (*iter)->datatype, NOARG);
      }
    }
  ;

varlist : varlist  T_COMMA varref { $1.push_back ($3); $$ = $1; }
      | varref { $$.push_back ($1); }
      ;

expr_list : expr_list  T_COMMA a_expr 
    { 
      $1.push_back ($3); $$ = $1; 
      #ifdef _SMP_DEBUG_
      cout << "In expr_list (1)\n";
      #endif
    }
  | a_expr 
    { 
      $$.push_back ($1); 
      #ifdef _SMP_DEBUG_
      cout << "In expr_list (2)\n";
      #endif
    }
  ;

%%

void yy::simple_parser::error (const yy::location & l, const std::string & s) {
	std::cerr << "Simple Parser error at " << l << " : " << s << std::endl;
}
