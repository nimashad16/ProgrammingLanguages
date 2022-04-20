#include <stdio.h>
#include "simple.h"


extern int yyparse ();

int main ()
{
  int ret;
  yylloc.first_line = yylloc.last_line = 1;
  yylloc.first_column = yylloc.last_column = 0;
  ret = yyparse ();
  if (!ret)
    printf ("PASS\n");
  else
    printf ("FAIL\n");
  return 0;
}
