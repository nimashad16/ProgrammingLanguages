#ifndef _SIMPLE_SYMTAB_H_

#define _SIMPLE_SYMTAB_H_

#include <vector>
#include <map>
#include <string>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <assert.h>

using namespace std;

#define SIMPLE_MAXLEN 50

#define DTYPE_INT 0
#define DTYPE_FLOAT 1



struct simple_symbol {
  string name;
  int  addr;
  int  datatype; // 
};

typedef struct simple_symbol symbol_t;

typedef map<string,symbol_t*> mapsym_t;
typedef map<string,symbol_t*>::iterator itersym_t;
typedef vector<symbol_t*> vector_sym_t;
typedef vector<symbol_t*>::iterator vector_itersym_t;


struct symbol_table {
  mapsym_t * map;
  int offset;
  int ntemp;
};

typedef struct symbol_table symtab_t;

extern
symtab_t * symtab_create ();

extern
void symtab_free (symtab_t * symtab);

extern
symbol_t * symbol_create (symtab_t * symtab, string p_name, int p_type);

extern
void symbol_show (symbol_t * sym);

extern
void symbol_free (symbol_t * sym);

extern
int symbol_add (symtab_t * & symtab, symbol_t * & sym);

extern
symbol_t * symbol_find (symtab_t * symtab, string sym_name);

extern
void symtab_show (symtab_t * symtab);

extern
symbol_t * make_temp (symtab_t * symtab, int p_type);

#endif
