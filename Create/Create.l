%{
	/* Declaration */
	#include "y.tab.h"
	int pkey_count=0;
%}

/* For case insensitive */

letter      [a-zA-Z]
digit       [0-9]
create		[cC][rR][eE][aA][tT][eE]
table 		[tT][aA][bB][lL][eE]
database	[dD][aA][tT][aA][bB][aA][sS][eE]
char 		[cC][hH][aA][rR]
varchar		[vV][aA][rR][cC][hH][aA][rR]
int			[iI][nN][tT]
smallint	[sS][mM][aA][lL][lL][iI][nN][tT]
bigint		[bB][iI][gG][iI][nN][tT]
float		[fF][lL][oO][aA][tT]
bool		[bB][oO][oO][lL]
date		[dD][aA][tT][eE]
notnull 	[nN][oO][tT][\' \'][nN][uU][lL][lL]
pkey		[pP][rR][iI][mM][aA][rR][yY][\' \'][kK][eE][yY]
unique		[uU][nN][iI][qQ][uU][eE]

%%

[\' \']+[ \t]*                              return SPACE;		
\n     										return NEWLINE;
{create}         						    return CREATE;
{table}                 				    return TABLE;
{database}	      						    return DATABASE;
({notnull}|{unique})						return CONSTRAINT;
{pkey}										{ 	
												if(pkey_count==0){
													pkey_count=1;
													return PKEY;
												}
												else
													printf("Only 1 primary key is allowed!\n");
											}
[_]?({letter}[_]?)+(({digit}[_]?)*({letter}[_]?)*)* 				return NAME;
[_]?({letter}[_]?)+(({digit}[_]?)*({letter}[_]?)*)*([\' \']+[ \t]*)((({char}|{varchar}|{int}|{smallint}|{bigint}|{float})([(]{digit}+[)])?)|{bool}|{date}) return FIELD;
.      										return *yytext;	
%%

/*	Auxillary function
	-yywrap function */
int yywrap(){
	return 1;
}