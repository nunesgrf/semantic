#ifndef TREE_H
#define TREE_H

#include "symbol_table.h"

typedef struct Node {
  struct Node* childNode1;
  struct Node* childNode2;
  struct Symbol* s_token;
  char   n_title[100];
  char   n_type[6];
  char   n_cast[6];
} Node;

#endif