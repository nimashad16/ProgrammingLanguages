#ifndef _SIMPLE_ICODE_H_

#define _SIMPLE_ICODE_H_

#include <vector>
#include <map>
#include <string>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "symtab.hh"

using namespace std;

#define TBDARG -2
#define NOARG -1

// Operations where the datatype is embedded into the instruction 
#define OP_LOAD 0
#define OP_STORE 1
#define OP_LOADCST 2
#define OP_WRITE 3
#define OP_READ 4

// Arithmetic Operations specific to datatypes
#define OP_ADD 5
#define OP_SUB 6
#define OP_MUL 7
#define OP_DIV 8
#define OP_UMIN 9

// Floating point opcode
#define OP_FADD 10
#define OP_FSUB 11
#define OP_FMUL 12
#define OP_FDIV 13
#define OP_FUMIN 14

#define OP_LT 20
#define OP_GT 21
#define OP_LEQ 22
#define OP_GEQ 23

#define OP_JMP 30
#define OP_JNZ 31
#define OP_JZ  32

#define OP_STORE_ARRAY_VAL_INT    33
#define OP_STORE_ARRAY_VAL_FLOAT  34
#define OP_LOAD_ARRAY_VAL_INT     35
#define OP_LOAD_ARRAY_VAL_FLOAT   36

#define OP_CAST_FLOAT2INT 50
#define OP_CAST_INT2FLOAT 51

#define SMP_SUCCESS 0
#define SMP_ERROR 1

#define UNUSED_ARG -1
#define TBD_ARG -2
#define DEFINE_ME -3


// Simple 3-address structure
struct simple_icode {
  int op_code;
  int addr1;
  int addr2;
  int addr3;
};
// a := b + c ==> addr1 := addr2 o_code addr3

typedef struct simple_icode icode_t;

struct simple_itab {
  vector<icode_t*> tab;
};

typedef struct simple_itab itab_t;

extern
itab_t * itab_create ();

extern
void icode_show (icode_t * icode);

extern
void itab_free_table (itab_t * itab);

extern
void itab_show (itab_t * itab);

extern
int itab_instruction_add (itab_t * itab, int opcode, int addr1, int addr2, int addr3);

extern
char * prepare_runtime (symtab_t * symtab, itab_t * itab);

extern
int run (itab_t * itab, char * stack, char * static_mem);

#endif
