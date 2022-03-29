/* yacc code to generate sql parser */
%{
/*	definition section	*/
	#include<stdio.h>
%}

%%  /*	rules section	*/

%token DROP TABLE DATABASE IDENTIFIER NEWLINE;
start : drop_command NEWLINE {printf("Syntax Correct\n"); return 0;}
drop_command : drop table itemname ';'
drop: DROP;
table : TABLE;
itemname: IDENTIFIER ',' itemname  /*	condition for multiple table/ databases name	*/
	| IDENTIFIER

%%  /*	yacc error handler	*/
yyerror(const char *str) {
	printf("wrong syntax");
	return 1;
}

/*	driver code	*/
int main() {
	printf("Enter Command : ");
	yyparse();
}
