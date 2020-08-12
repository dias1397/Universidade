#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define SIZE 269

enum
{
    INT,
    FLOAT,
    STRING,
    BOOLEAN,
    VOID,
    ARRAY/*,
    FUCTION*/
}t_type;

typedef struct node node;

struct node
{
    char *id;
    t_type type;
    int empty;
    node *table;
};

char *scope = -1;
node hastable[SIZE];
////////
int search(node hastable, char *id)
{
    int asci = 0;
    while(*id != '\0')
    {
        asci += id;
        *id++;
    }
    int pos = asci % SIZE;
    while(hashtable[pos].empty != 1)
    {
        pos ++;
    }

    return pos;
}

void insert_variable(node table, char *arg0, t_type arg1)
{
    int pos = search(arg0);

    table[pos].id = arg0;
    table[pos].type = arg1;
    table[pos].empty = 1;
}
void insert_fuction(node table, char *arg0, t_types arg1/*, ARFUMENTOS */)
{
    int pos = search(arg0);

    table[pos].id = arg0;
    table[pos].type = arg1;
    table[pos].empty = 1;

    node new_hash[SIZE] = (node) malloc(sizeof(node)*SIZE);
    table[pos].table = new_hash;

    scope = id;
}
t_type lookup(char *id)
{
    if(scope != -1)
    {
        int pos = search(hastable,scope)

        int pos_scope = search(hastable[pos].table, id);

        while(hastable[pos].table[pos_scope].empty==1)
        {
            if(strcmp(hastable[pos].table[pos_scope].id, id)==0)
                return hastable[pos].table[pos_scope].table.type;
            pos_scope++;
        }
    }
    int pos = search(hastable,id)

    while(hastable[pos].empty==1)
    {
        if(strcmp(hastable[pos].table[pos_scope].id, id)==0)
            return hastable[pos].table[pos_scope].table.type;
        pos++;
    }
    return null;
}