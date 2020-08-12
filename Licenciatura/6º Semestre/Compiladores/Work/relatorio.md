## Analise Lexical

A primeira fase da implementação de um compilador para a linguagem YA! consiste na criação do analisador lexical. Esta fase tem como objetivo ler o codigo fonte e detectar as palavras reservadas da linguaguem. Estas palavras são entre outras "if", "then", "else", "int", etc. Estes simbolos não vão poder ser usados como por exemplo ID numa declaração.

O analisador lexical será um automato finito e gerado pelo flex. As expressões regulares serão usadas para literais inteiros, floats, strings e ID's.

O output deste analisador irá ser uma stream de Tokens que servirá para criar a APT do respetivo programa.

## Analise Sintática

Tendo o analisador lexical implementado, o próximo passo consiste na criação da gramática para a nossa linguaguem. Recebendo uma stream de tokens gerada pelo analisador lexical, será gerada a APT(abstract parse tree) consoante a gramática definida.

Este analisador denominado de sintáctico ou parser vai ser gerado pelo bison. Durante esta analise pode surgir um erro sintactico que origina o fim do processo.

Durante esta análise são gerados os nós da apt para mais tarde executar a analise semantica e criar o ficheiro latex com a respetiva arvore.

## Symbol Table

