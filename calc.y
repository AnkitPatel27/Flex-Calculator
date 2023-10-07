%{
void yyerror (char *s);
int yylex();
#include <math.h>
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
double symbols[52];
double symbolVal(char symbol);
void updateSymbolVal(char symbol, double val);
%}

%union {double num; char id;}         /* Yacc definitions */
%start line
%token print
%token exit_command
%token <num> number
%token <id> identifier
%type <num> line exp exp2 exp3 term 
%type <id> assignment

%%

/* descriptions of expected inputs     corresponding actions (in C) */

line    : assignment ';'		{;}
		| exit_command ';'		{exit(EXIT_SUCCESS);}
		| print exp ';'			{printf("Printing %f\n", $2);}
		| line assignment ';'	{;}
		| line print exp ';'	{printf("Printing %f\n", $3);}
		| line exit_command ';'	{exit(EXIT_SUCCESS);}
        ;

assignment : identifier '=' exp  { updateSymbolVal($1,$3); }
		   ;

exp    	: exp2                  {$$ = $1;}
       	| exp '+' exp2          {$$ = $1 + $3;}
       	| exp '-' exp2          {$$ = $1 - $3;}
		;

exp2    : exp3                  {$$ = $1;}
       	| exp2 '*' exp3          {$$ = $1 * $3;}
       	| exp2 '%' exp3          {$$ = (int)$1 % (int)$3;}
       	| exp2 '/' exp3          {$$ = $1 / $3;}
       	;

exp3    : term                  {$$ = $1;}
       	| exp3 '^' term          {$$ = pow($1,$3);}
       	;

term   	: number                {$$ = $1;}
		| '(' exp ')'          	{$$ = $2;}
		| identifier			{$$ = symbolVal($1);} 
        ;

%%                     /* C code */

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
double symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, double val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

