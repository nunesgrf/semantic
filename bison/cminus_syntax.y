/* Verificando a sintaxe de um programa na linguagem c-- .c-- */
%define parse.error verbose
%define lr.type canonical-lr
%{

#include <stdio.h>
#include "symbol_table.h"

extern int yylex();
extern FILE *yyin;
extern int yylex_destroy();
void yyerror(const char* e){
    printf("%s\n", e);

}

int scope = 0;
int memoryAddress = 0;
%}

%union{
	struct Token {
        int     line;
        int     column;
        char    name[101];
    } token;
	char* type;
}

%token <token> letter
%token <token> id
%token <token> digit
%token <token> integer
%token <token> tp_inteiro
%token <token> tp_vazio
%token <token> op_add 
%token <token> op_sub 
%token <token> op_mul 
%token <token> op_div 
%token <token> op_igual
%token <token> op_maig
%token <token> op_meig
%token <token> op_maior
%token <token> op_menor
%token <token> op_diff
%token <token> op_atr
%token <token> op_virgula
%token <token> op_pvirgula
%token <token> cmd_if
%token <token> cmd_else
%token <token> cmd_while
%token <token> cmd_return
%token <token> parent_esq
%token <token> parent_dir
%token <token> colch_esq
%token <token> colch_dir
%token <token> chave_esq
%token <token> chave_dir
%token <token> comment

%type <type> type

%%

main: 
	type id parent_esq parent_dir chave_esq comandos chave_dir {}
;
comandos:
	comandos comando {}
	| comando {}
;
comando :
    declaration op_pvirgula {}
	| atribuicao op_pvirgula {}
	| cmd_return expressaoAdd op_pvirgula {}
	| enquanto {}
;
enquanto:
	cmd_while {scope++;} parent_esq expressao parent_dir chave_esq comandos chave_dir {scope--;}
;
declaration:
	type id {
		if (!existsInSymbolTable($2.name, scope)) {
			Symbol * symbol = makeSymbol($1, $2.name, $2.line, $2.column, scope, memoryAddress); 
			insertSymbol(symbol);
			memoryAddress++;
		}
		else {
			printf("ERRO SEMÂNTICO: Redeclaração da variável %s.\n", $2.name);
		}

	}
;
atribuicao:
	id op_atr expressao {}	
;
expressao:
	expressaoAdd simboloLogico expressaoAdd {}
	| expressaoAdd {}
;
expressaoAdd:
	expressaoAdd addsub expressaoMul {}
	| expressaoMul {}
;
expressaoMul:
	expressaoMul muldiv termo {}
	| termo {}
;
type:
	tp_inteiro { $$ = "int"; }
	| tp_vazio { $$ = "vazio"; }
;
termo: 
	parent_esq expressaoAdd parent_dir {}
	| id {
		Symbol * symbol = readByNameAndThresholdScope($1.name, scope);
		if (symbol != NULL) {
			symbol->used = 1;
		}
		else {
			printf("ERRO SEMÂNTICO: Variável %s não declarada.\n", $1.name);
		}	
	}
	| integer {}
;
simboloLogico:
	op_igual {}
	| op_maig {}
	| op_meig {}
	| op_maior {}
	| op_menor {}
	| op_diff {}
;
muldiv:
	op_mul {}
	| op_div {}
;
addsub:
	op_add {}
	| op_sub {}
;
%%

int main(){
    // #ifdef YYDEBUG
    //     yydebug=1;
    // #endif

	char nomeArqCMINUS[64];
	//char nomePastaArqCMINUS[] = "./tests/";
	FILE *arquivoCMINUS;

    printf("Insira o nome do arquivo dentro da pasta tests: ");
	scanf("%s", nomeArqCMINUS);
	//strcat(nomePastaArqCMINUS, nomeArqCMINUS);
	arquivoCMINUS = fopen(nomeArqCMINUS,"r");
	if(!arquivoCMINUS){
		printf("Nao foi possível abrir arquivo.\n");
		return -1;
	}
	yyin = arquivoCMINUS;

    //escopo_atual = 0;
    //escopo_ponteiro = 0;
    //simbolos_ponteiro = -1;

	yyparse();

	printTable();
    //imprimirTabelaSimbolos();


	fclose(arquivoCMINUS);
    //esvaziarTabela();
    //esvaziarArvore();
	yylex_destroy();
	return 0;
}