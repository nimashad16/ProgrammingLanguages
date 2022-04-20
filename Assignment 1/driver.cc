#include <iostream>
#include <string>
#include "tokens.h"

extern char * yytext;

extern
int yylex ();

int main ()
{
  int next;
  while ((next = yylex ()) != T_EOF) {
    printf ("token = %d (%s)\n", next, yytext);
  }

  return 0;
}
