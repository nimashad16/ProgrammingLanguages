%{ 
#include "simple.h"
# undef yywrap
# define yywrap() 1



#undef YY_DECL
#define YY_DECL int yylex()
YY_DECL;


// Code run each time a pattern is matched.
#undef  YY_USER_ACTION  
# define YY_USER_ACTION  {}



%}

%option yylineno
%option noyywrap 

DIGIT [0-9] 
ALPHA [a-zA-Z]

%%





\/\/.*$           { yylloc.last_line++; yylloc.last_column = 0;}	
[ ]+						  { yylloc.last_column++;}	
[\t]+						  { yylloc.last_column+=2;}	
[\n]+						  {yylloc.last_line++; yylloc.last_column = 0;}	

\".+\"						{ 
                    yylloc.last_column += strlen(yytext);
										return T_LITERAL_STR; 
                  }


":="							{ 
                    yylloc.last_column += 2;
										return T_ASSIGN; 
                  }

"+"							  { 
                    yylloc.last_column++;
										return T_ADD; 
                  }

"-"							  { 
                    yylloc.last_column++;
										return T_SUB; 
                  }

"*"							  { 
                    yylloc.last_column++;
										return T_MUL; 
                  }

"/"							  { 
                    yylloc.last_column++;
										return T_DIV; 
                  }

"<"							  { 
                    yylloc.last_column++;
										return T_LT; 
                  }

">"							  { 
                    yylloc.last_column++;
										return T_GT; 
                  }

">="							{ 
                    yylloc.last_column+=2;
										return T_GEQ; 
                  }

"<="							{ 
                    yylloc.last_column+=2;
										return T_LEQ; 
                  }

"="							  { 
                    yylloc.last_column+=1;
										return T_EQ; 
                  }

"<>"							{ 
                    yylloc.last_column+=2;
										return T_NEQ; 
                  }

"and"							{ 
                    yylloc.last_column+=3;
										return T_AND; 
                  }

"or"							{ 
                    yylloc.last_column+=2;
										return T_OR; 
                  }
  
"foreach"				  { 
                    yylloc.last_column+=7;
										return T_FOREACH; 
                  }

"in"				      { 
                    yylloc.last_column+=7;
										return T_IN; 
                  }

"while"				    { 
                    yylloc.last_column+=5;
										return T_WHILE; 
                  }

"begin"					  { 
                    yylloc.last_column+=5;
										return T_BEGIN; 
                  }

"end"				      { 
                    yylloc.last_column+=3;
										return T_END; 
                  }

"if"				      { 
                    yylloc.last_column+=2;
										return T_IF; 
                  }

"then"				    { 
                    yylloc.last_column+=4;
										return T_THEN; 
                  }

"else"				    { 
                    yylloc.last_column+=4;
										return T_ELSE; 
                  }

"write"						{ 
                    yylloc.last_column+=5;
										return T_WRITE; 
                  }

"read"						{ 
                    yylloc.last_column+=4;
										return T_READ; 
                  }

"int"							{ 
                    yylloc.last_column+=3;
										return T_INTEGER; 
                  }

"float"						{ 
                    yylloc.last_column+=5;
										return T_FLOAT; 
                  }

"repeat"				  { 
                    yylloc.last_column+=6;
										return T_REPEAT; 
                  }

"until"				    { 
                    yylloc.last_column+=5;
										return T_UNTIL; 
                  }

"declare"					{ 
                    yylloc.last_column+=7;
										return T_DECLARE; 
                  }


{DIGIT}+[.]{DIGIT}+	{ 
                      yylloc.last_column += strlen(yytext);
                      return T_NUM;
									  }

{DIGIT}+					{ 
                    yylloc.last_column += strlen(yytext);
										return T_NUM;
									}

({ALPHA}|[_])({DIGIT}|{ALPHA}|[_])*     { 
                                          yylloc.last_column += strlen(yytext);
																					return T_ID;
																				}

.									{  yylloc.last_column++; return yytext[0];}





%%
