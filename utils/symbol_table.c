#include "symbol_table.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int position = 0;
Symbol* symbols[100100];

Symbol * makeSymbol(char* type, char* name, int line, int column, int scope, int memoryAddress) {
    Symbol* symbol = (Symbol*)malloc(sizeof(Symbol));
    
    strcpy(symbol->type, type);
    strcpy(symbol->name, name);
    symbol->line = line;
    symbol->column = column;
    symbol->scope = scope;
    symbol->memoryAddress = memoryAddress;
    symbol->used = 0;

    return symbol;
}

void insertSymbol(Symbol* symbol) {
    symbols[position++] = symbol;
}

Symbol* readByNameAndThresholdScope(char* name, int thresholdScope) {
    Symbol * symbol = NULL;
    int maximumScope = -1;
    for (int i = 0; i < position; i++) {
        if (strcmp(symbols[i]->name, name) != 0) {
            continue;
        }

        if (symbols[i]->scope <= thresholdScope) {
            if (maximumScope < symbols[i]->scope) {
                symbol = symbols[i];
                maximumScope = symbols[i]->scope;
            }
        }
    }

    return symbol;
}

int existsInSymbolTable(char* name, int scope) {
    for (int i = 0; i < position; i++) {
        if (strcmp(symbols[i]->name, name) == 0 && symbols[i]->scope == scope) {
            return 1;
        }
    }
    return 0;
}

void printTable() {
    for (int i = 0; i < 88; i++) {
        printf("-");
    }
    printf("\n");
    printf("| %-8s | %-20s | %-14s | %-6s | %-6s | %-6s | %-6s |\n",
        "TYPE",
        "NAME",
        "MEMORY ADDRESS",
        "SCOPE",
        "LINE",
        "COLUMN",
        "USED");
    for (int i = 0; i < 88; i++) {
        printf("-");
    }
    printf("\n");

    for (int i = 0; i < position; i++) {
        
        printf("| %-8s | %-20s | %-14d | %-6d | %-6d | %-6d | %-6s |\n",
            symbols[i]->type,
            symbols[i]->name,
            symbols[i]->memoryAddress,
            symbols[i]->scope,
            symbols[i]->line,
            symbols[i]->column,
            symbols[i]->used? "YES" : "NO");
        
    }
    for (int i = 0; i < 88; i++) {
        printf("-");
    }
    printf("\n");
}
