#ifndef GRAPH_H
#define GRAPH_H

#include "queue.h"
#include "divisao.h"

list *initialize_single_source(memory *mem, divisao *div);

void relax(list *list, node *u, int id, int p, node* to_change);
int travel_weight(node *src, node *dest, bool ultima);

int dijkstra(memory *mem, divisao*src, divisao *end);

#endif