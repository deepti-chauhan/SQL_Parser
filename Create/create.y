%{
	/* Declaration */
	#include<stdio.h>
%}

%%

/* Specifying tokens*/
%token CREATE TABLE DATABASE SPACE NAME FIELD CONSTRAINT PKEY NEWLINE;

/* Defining CFG for CREATE COMMAND */

/* start is the starting non terminal that takes command entered by user and if its correct print msg */

start : Create_command NEWLINE {printf("Correct syntax"); return 0;}



/* Create_command is a non terminal which is defined as a combination of token name specified in .l file.
	Either user can create table or create database using it.In case of create table, it move to NEW_FIELD 
	non terminal for column definition. It should be ended by a semicolon. */

Create_command : CREATE SPACE TABLE SPACE NAME SPACE '('NEW_FIELD')'';'
               | CREATE SPACE DATABASE SPACE NAME ';'



/* NEW_FIELD is a non terminal which is defined as a combination of token name specified in .l file.
	User can specify multiple column names and its data type with or without constraint. */

NEW_FIELD : FIELD SPACE CONSTRAINTS ',' NEW_FIELD
		  | FIELD ',' NEW_FIELD
		  | FIELD SPACE CONSTRAINTS
		  | FIELD



/* CONSTRAINT is a non terminal which is defined as a combination of token name specified in .l file.
	User can specify multiple constraint like primary key,not null,unique. */

CONSTRAINTS : CONSTRAINT SPACE CONSTRAINTS
			| PKEY SPACE CONSTRAINTS
			| PKEY
			| CONSTRAINT
%%

/* Auxillary functions */
/* yyerror function */
yyerror(char const* s)
{
	printf("Syntax Error");
	return 1;
}

/* main function */
int main()
{
	printf("\nPlease enter the command to create a table:\n");
	yyparse();
	return 0;
}
