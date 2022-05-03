%{
#include <stdio.h>
#include <string.h>
#include "cminus_syntax.tab.h"

#define PREPARATOKEN strcpy(yylval.token.name, yytext); yylval.token.line = line; yylval.token.column = column

int column = 1;
int line = 1;
int errorCount = 0;
%}

letter [a-zA-Z]
id	{letter}+

digit      [0-9]
integer    {digit}+

tp_inteiro (int)
tp_vazio   (void)

op_add [+]
op_sub [-]
op_mul [*]
op_div [/]

op_igual  (==)
op_maig   (>=)
op_meig   (<=)
op_maior  [<]
op_menor  [>]
op_diff   (!=)
op_atr	  [=]

op_virgula [,]
op_pvirgula [;]

cmd_if		if
cmd_else	else
cmd_while	while
cmd_return	return

parent_esq [(]
parent_dir [)]
colch_esq  (\[)
colch_dir  (\])
chave_esq  (\{)
chave_dir  (\})

comment   \/\*[^\*\/]*\*\/

%%
\n 					{line++; column = 1;}
[ \t]+				{column += yyleng;}

{integer}		   	{PREPARATOKEN; column += yyleng;	return integer;}

{tp_inteiro}	 	{PREPARATOKEN; column += yyleng;	return tp_inteiro;}
{tp_vazio}		 	{PREPARATOKEN; column += yyleng;	return tp_vazio;}

{op_add}		   	{PREPARATOKEN; column += yyleng;	return op_add;}
{op_sub}		   	{PREPARATOKEN; column += yyleng;	return op_sub;}
{op_mul}		   	{PREPARATOKEN; column += yyleng;	return op_mul;}
{op_div}		   	{PREPARATOKEN; column += yyleng;	return op_div;}

{op_igual}		   	{PREPARATOKEN; column += yyleng;	return op_igual;}
{op_maior}		   	{PREPARATOKEN; column += yyleng;	return op_maior;}
{op_menor}		   	{PREPARATOKEN; column += yyleng;	return op_menor;}
{op_maig}		   	{PREPARATOKEN; column += yyleng;	return op_maig;}
{op_meig}		   	{PREPARATOKEN; column += yyleng;	return op_meig;}
{op_diff}		   	{PREPARATOKEN; column += yyleng;	return op_diff;}
{op_atr}		   	{PREPARATOKEN; column += yyleng;	return op_atr;}

{op_virgula}	 	{PREPARATOKEN; column += yyleng;	return op_virgula;}
{op_pvirgula}	 	{PREPARATOKEN; column += yyleng;	return op_pvirgula;}

{parent_esq}	  	{PREPARATOKEN; column += yyleng;	return parent_esq;}
{parent_dir}	 	{PREPARATOKEN; column += yyleng;	return parent_dir;}
{colch_esq}		  	{PREPARATOKEN; column += yyleng;	return colch_esq;}
{colch_dir}		  	{PREPARATOKEN; column += yyleng;	return colch_dir;}
{chave_esq}		  	{PREPARATOKEN; column += yyleng;	return chave_esq;}
{chave_dir}		  	{PREPARATOKEN; column += yyleng;	return chave_dir;}


{cmd_if}		  	{PREPARATOKEN; column += yyleng;	return cmd_if;}
{cmd_else}			{PREPARATOKEN; column += yyleng;	return cmd_else;}
{cmd_while}			{PREPARATOKEN; column += yyleng;	return cmd_while;}
{cmd_return}		{PREPARATOKEN; column += yyleng;	return cmd_return;}

{id}			    {PREPARATOKEN; column += yyleng;	return id;}



{comment}	    	{printf("Comentário\n");			return comment;}
.             		{printf("Cadeia indefinida: %s\nline: %d\n Coluna: %d\n", yytext, line, column); column += yyleng; errorCount++;}


%%

int yywrap() {
  return 1;
}
