%{ 
#include "simple.hh"
#include <cerrno>
#include <climits>
#include <cstdlib>
#include <string>

# undef yywrap
# define yywrap() 1


using namespace std;
using namespace yy;

#undef YY_DECL
#define YY_DECL yy::simple_parser::symbol_type yylex()
YY_DECL;

yy::location loc;

// Code run each time a pattern is matched.
# define YY_USER_ACTION  loc.columns (yyleng);



%}

%option yylineno
%option noyywrap 

DIGIT [0-9] 
ALPHA [a-zA-Z]

%%

%{
  // Code run each time yylex is called.
  loc.step ();
%}




\/\/.*$   
[ \t]+						{ loc.step (); }
[\n]+							{ loc.lines (yyleng); loc.step (); }


"write"            { 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_WRITE(loc); 
                  }

"read"            { 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_READ(loc); 
                  }

":="							{ 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_ASSIGN(loc); 
                  }

";"							{ 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_SEMICOLON(loc); 
                  }

","							{ 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_COMMA(loc); 
                  }


"+"							  { 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_ADD(loc); 
                  }

"-"							  { 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_SUB(loc); 
                  }

"*"							  { 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_MUL(loc); 
                  }

"/"							  { 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_DIV(loc); 
                  }

"int"							{ 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_DT_INT(loc); 
                  }

"float"							{ 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_DT_FLOAT(loc); 
                  }

{DIGIT}+[.]{DIGIT}+	{ 
                      //yylval->build (yytext);
                      return yy::simple_parser::make_T_FLOAT ((float)(atof(yytext)),loc);
									  }

{DIGIT}+					{ 
										//yylval->build (yytext);
										return yy::simple_parser::make_T_INTEGER (atoi(yytext),loc);
									}

({ALPHA}|[_])({DIGIT}|{ALPHA}|[_])*     { 
																					//yylval->build (yytext);
																					return yy::simple_parser::make_T_ID (string(yytext),loc);
																				}

<<EOF>>						{ return yy::simple_parser::make_T_EOF (loc); }
.									{ printf ("Unexpected character\n"); exit (1); }





%%
