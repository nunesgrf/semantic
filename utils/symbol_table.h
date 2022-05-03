#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Symbol {
    char    type[6];
    char    funcvar[11];
    int     line;
    int     column;
    int     scope;
    char    title[101];
    int     numParams;
    char    typeParams[100][6];
} Symbol;

#endif