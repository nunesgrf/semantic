#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Symbol {
    char type[6];    
    int line;
    int column;
    int scope;
    char name[101];
    int memoryAddress;
    int used;
} Symbol;

void printTable();
void insertSymbol(Symbol* symbol);
int existsInSymbolTable(char* name, int scope);
Symbol* makeSymbol(char* type, char* name, int line, int column, int scope, int memoryAddress);
Symbol* readByNameAndThresholdScope(char* name, int scope);
#endif