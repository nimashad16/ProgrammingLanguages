#include "symtab.hh"
#include "icode.hh"
#include "simple.hh"



int main ()
{
  int ret;
  symtab_t * symtab;
  itab_t * itab;
  char * static_mem;
  static_mem = new char[1024];

  symtab = symtab_create ();
  assert (symtab);
  itab  = itab_create ();
  assert (itab);

  // Parsing and Intermediate Codegen
  yy::simple_parser parser (symtab, itab, static_mem);

  ret = parser.parse ();
  #ifdef _SMP_DEBUG_
  if (!ret)
    printf ("Syntax OK\n");
  #endif
  if (ret)
  {
    printf ("Syntax ERROR\n");
    assert (0 && "Aborting due to syntax error");
  }

  // Runtime preparation and program execution
  #ifdef _SMP_DEBUG_
  printf ("\n------------------------------------------------------------\n");
  printf ("Showing Symbol Table\n");
  symtab_show (symtab);
  fflush (stdout);
  printf ("\n------------------------------------------------------------\n");
  printf ("Showing Instruction Table\n");
  itab_show (itab);
  fflush (stdout);
  printf ("\n------------------------------------------------------------\n");
  #endif
  char * stack = prepare_runtime (symtab, itab);
  fflush (stdout);
  printf ("\n------------------------------------------------------------\n");
  printf ("\nProgram's Output:\n");
  ret = run (itab, stack, static_mem);
  fflush (stdout);
  printf ("\n------------------------------------------------------------\n");

  // Be clean
  itab_free_table (itab);
  symtab_free (symtab);
  delete stack;
  delete static_mem;

  return 0;
}
