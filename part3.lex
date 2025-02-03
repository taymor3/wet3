%{
    /* declarations */
    using namespace std;
    #include <map>
    #include <string>
    #include <iostream>
    #include <stdio.h>
    #include <stdlib.h>
    
    #include "part3_helpers.hpp"
    #include "part3.tab.hpp"

    extern "C" int yylex();
%}
/* definitions */
%option outfile="part3_lex.cpp"
%option yylineno
%option noyywrap

digit        ([0-9])
letter       ([a-zA-Z])
whitespace   ([ \t\n])
symbol       [(){},;:]|\.{3}
id           {letter}({letter}|{digit}|_)*
integernum   {digit}+
realnum      {digit}+\.{digit}+
str          \"([^"\\\n\r]|\\[tn"])*\"
relop        "=="|"<>"|"<"|"<="|">"|">="
addop        "+"|"-"
mulop        "*"|"/"
assign       "="
and          "&&"
or           "||"
not          "!"
comment      "#"[^\n]*

/* rules */
%%

int	{
	return tk_int;
}

float {
	return tk_float;
}

void {
	return tk_void;
}

write {
	return tk_write;
}

read {
	return tk_read;
}

va_arg {
	return tk_va_arg;
}

while {
	return tk_while;
}

do {
	return tk_do;
}

if {
	return tk_if;
}

then {
	return tk_then;
}

else {
	return tk_else;
}

return {
	return tk_return;
}

{symbol} {
    yylval.name = strdup(yytext);
	if (yytext[0] != '.') {
		return yytext[0];
	} else {
		return tk_ellipsis;
	}
}

{integernum} {
	yylval.name = strdup(yytext);
	return tk_integernum;
}

{realnum} {
	yylval.name = strdup(yytext);
	return tk_realnum;
}

{id} {
	yylval.name = strdup(yytext);
	return tk_id;
}

{relop} {
	yylval.name = strdup(yytext);
	return tk_relop;
}

{addop} {
	yylval.name = strdup(yytext);
	return tk_addop;
}

{mulop} {
	yylval.name = strdup(yytext);
	return tk_mulop;
}

{assign} {
	return tk_assign;
}

{and} {
	return tk_and;
}

{or} {
	return tk_or;
}

{not} {
	return tk_not;
}

{str}	{
			char* trim = yytext;
			trim[yyleng-1] = 0; /* remove ending " */
			trim++; /* remove first " */
			yylval.name = strdup(trim);
			return tk_str;
}

{comment}			;
{whitespace}		;

.   { cerr << "Lexical error: '" << yytext << 
      "' in line number " << yylineno << endl;
	  exit(LEXICAL_ERROR);
	}

%% 
