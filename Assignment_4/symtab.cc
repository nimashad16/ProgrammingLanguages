#include "symtab.hh"

symbol_t * symbol_create_array (symtab_t * symtab, string p_name, int p_type, int p_len)
{
  symbol_t * ret;
  //ret = (symbol_t*)malloc (sizeof(symbol_t));
  ret = new symbol_t;
  ret->addr = symtab->offset;
  ret->name = p_name;
  ret->datatype = p_type;
  ret->len = p_len;
  // Update offset considering the array size (1 if not array).
  switch (p_type)
  {
    case DTYPE_INT: symtab->offset += sizeof(int) * ret->len;
      break;
    case DTYPE_FLOAT: symtab->offset += sizeof(float) * ret->len;;
      break;
    default: assert (0 && "No other datatypes are supported");
  }
  return ret;
}

symbol_t * symbol_create (symtab_t * symtab, string p_name, int p_type)
{
  symbol_t * sym = symbol_create_array (symtab, p_name, p_type, 1);
  return sym;
}

void symbol_free (symbol_t * sym)
{
  free (sym);
}

symtab_t * symtab_create ()
{
  symtab_t * ret;
  ret = new symtab_t;
  ret->map = new mapsym_t;
  ret->offset = 0;
  ret->ntemp = 0;
  return ret;
}

int symbol_add (symtab_t * & symtab, symbol_t * & sym)
{
  assert (sym);
  assert (symtab);
  (*(symtab->map))[sym->name] = sym;
  return symtab->map->size () - 1; // returns index of last created symbol
}

symbol_t * make_temp (symtab_t * symtab, int dtype)
{
  char tempname[20];
  sprintf (tempname, "_T%d", symtab->ntemp++);
  symbol_t * ret = symbol_create (symtab, string(tempname), dtype);
  int discardme = symbol_add (symtab, ret);
  return ret;
}

symbol_t * symbol_find (symtab_t * symtab, string sym_name)
{
  itersym_t sym;
  sym = symtab->map->find (sym_name);
  if (sym != symtab->map->end ())
    return sym->second;
  return NULL;
}

static
string get_type_str (symbol_t * sym)
{
  if (sym->datatype == DTYPE_INT)
    return "int";

  if (sym->datatype == DTYPE_FLOAT)
    return "float";

  return "Undefined Data Type";
}

void symbol_show (symbol_t * sym)
{
  cout << sym->name << " |\t " << sym->addr << " |\t " << get_type_str (sym) << " |\t " << sym->len << endl;
}

void symtab_free (symtab_t * symtab)
{
  mapsym_t::iterator ss;
  for (ss = symtab->map->begin (); ss != symtab->map->end (); ss++)
    symbol_free (ss->second);
  delete (symtab->map);
  free (symtab);
}

void symtab_show (symtab_t * symtab)
{
  mapsym_t::iterator ss;
  int id = 0;
  printf ("\t Name |\t Address |\t Datatype |\t Length\n");
  for (ss = symtab->map->begin (); ss != symtab->map->end (); ss++, id++)
  {
    printf ("Symbol %d: ", id);
    symbol_show (ss->second);
  }
}
