%{
	/*	definition section	*/
	#include "y.tab.h"
%}
letter 	[a-zA-Z]
digit	[0-9]

%%   /* rules section */
[dD][rR][oO][pP]											return DROP;
[tT][aA][bB][lL][eE]|[dD][aA][tT][aA][bB][aA][sS][eE]		return TABLE;
({letter}[_]?)({digit}[_]?|{letter}[_]?)* 					return IDENTIFIER;
\n															return NEWLINE;
[ \t]+														/* ignore whitespace */;
.															return *yytext;
%%


int yywrap() { /*	return 1 if done, 0 if not done	  */
	return 1;
}
