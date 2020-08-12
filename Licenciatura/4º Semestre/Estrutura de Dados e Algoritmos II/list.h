#include <stdbool.h>


struct list *list;

struct list *list_new();

bool list_empty(struct list *list);

bool list_insert(struct list *list, int data);

bool list_remove(struct list *list, int data);

void list_print(struct list *list);

int list_find(struct list * list, int data);

void list_destroy(struct list *list);

int list_length(struct list *list);

int list_nth(struct list *list, int n);

struct list *list_open(char *name);

int list_close(struct list *list);