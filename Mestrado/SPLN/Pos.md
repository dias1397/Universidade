Capitulo 8

Pensa-se ter sido Dionysius Thrax of Alexandria quem escreveu um sketch grego que resume o conhecimento linguistico dos dias de hoje. Neste sketch surgiram alguns termos como sintaxe, ditongo e analogia. Tambem neste trabalho está incluido uma descrição das oito partes-de-discurso. 
São estas partes-de-discurso que ainda hoje assentam na base das linguaguens europeias, depois de terem resistido a dois milénios. As oito partes são nome, verbo, pronome, preposição, adverbio, conjunção, participle e artigo.
Estas partes tambem conhecidas por POS, são uteis pois revelam informação sobre a própria palavra e os seus vizinhos.

Exemplo:
-Nomes são precedidos por determinantes ou adjectivos.
-Verbos são precedidos por nouns.

Partes-de-discurso tambem são uteis para fazer o parsing, nomear entidades ou até mesmo para reconhecimento de voz.

8.1
As partes-de-discurso são tradicionalmente definidas pelo seu aspecto sintáctico e/ou morfológico. Podem assim ser divididas em duas supercategorias: classe fechada ou classe aberta.
São exemplos de membros da classe fechada as preposições pois nesta classe não há muito por onde expandir havendo um numero fixo de "membros". Pelo contrário, nomes e verbos, são classes abertas, pois existem sempre novos a serem criados como o nome IPhone. 
A classe dos substantivos é dividida em substantivos próprios e comuns, sendo estes ultimos divididos em substantivos contáveis e massivos. Já os verbos referem se a acções e processos explicitos em vários tempos. Apesar de se acreditar que todas as linguagens tem estas duas classes, acredita-se que algumas linguas não fazem a distinção das duas.
A terceira classe aberta é os adjectivos, que contem termos para propriedades e qualidades de algo. Mas nem todas as linguagens tem adjectivos, por exemplo o koreano usa uma extensão dos verbos como substituição.
A ultima classe é os adverbios, que podem ser visto como palavras que modificam alguma coisa.

Na classe fechada os seus membros diferem mais de linguagem para linguaguem. São classes fechadas importantes em Ingles as proposições, particulas, determinantes, conjunções, pronomes, verbos auxiliares e numerais.
Preposições: ocorrem antes de frases substantivas. Indicam relações espaciais e temporais.
Particula: é usada na combinação com um verbo.
Determinantes: ocorre antes de um substantivo. 
Conjunções: juntam duas frases ou expressões. Dividem se em conjunções coordenadas e subordinadas.
Pronomes: usados para se referir a um substantivo sem o usar. Existem pronomes pessoais e possessivos.
Verbos auxiliares: são subtipos da classe verbos.

8.2
As tags de Penn Treebank para as partes-de-discurso ajudam a simplificar a analise de uma frase. Esta analise utilizando estas tags é um bom treino para mais tarde se implementar algoritmos de tagging estatistico. 
As 45 tags de Peen proveem de 87 tags de Brown, por isso algumas distinções podem ter sido perdidas. Por exemplo a tag IN é usada tanto para conjuções subordinadas como para preposições. 
Antes de se proceder a tagging as palavras sao sempre transformadas em tokens.

8.3
O processo de fazer tagging às partes-de-discurso consiste em atribuir marcas a cada uma das palavras tendo em conta o seu tipo. O input será um conjunto de tokens representativos das partes-de-discurso.
Esta tarefa é ambigua pois as palavras são ambiguas, podendo ter mais do que uma parte-de-discurso.
Algumas palvras são facilmente desambiguadas usando um algoritmo simples que escolhe a parte-de-discurso mais frequente. Este algoritmo tem 92% de precisão.

8.4
O modelo oculto de Markov é um modelo de sequência. Um modelo de sequencia é um modelo que tem como função atribuir um rótulo ou uma classe a cada unidade de uma sequência. O HMM é um modelo sequencial probabilistico que dado uma sequencia de unidades, formula uma distribuição de probabilidades para possiveis rotulos, escolhendo o melhor.

8.4.1
Uma cadeia de Markov assume que apenas interessa o estado actual para prever o estado futuro.
A cada transição de estado corresponde uma probabilidade.
8.4.2
O modelo oculto de Markov permite tratar eventos observaveis (como palavras do input) e eventos ocultos (tags de parte-de-discurso).
8.4.3
O HMM contem dois componentes, as probabilidades A e B. A matriz A contem as probabilidades de uma tag ocorrer, tendo uma tag ocorrido antes. Por exemplo um verbo modal will tem grandes probabilidades de a seguir ser seguido por uma tag verbo. Estas probabilidades são calculadas por tagging de um corpus de treino.
B corresponde às probabilidadess de uma tag ser associada a uma palavra.
8.4.4
Para cada modelo que contenha variaveis ocultas, o processo de determinar a sequencia de variaveis ocultas correspondentes a sequencia de observações é chamado de descodificar. O uso de HMM tem como objectivo descobrir a sequencia de tags mais provaveis consoante uma sequencia de observações.
8.4.5
O algoritmo de descodificação para o HMM é o algoritmo Viterbi. Este algoritmo começa por criar uma matriz em que cada coluna corresponde a uma observação e uma linha para cada estado (tags). O valor para cada célula da matriz é depois calculado recursivamente tomando o caminho mais provavel até essa mesma célula.
8.4.7
No tagger falado previamente, todas as tags apenas dependem da tag anterior, mas em prática, uma tag depende das tuas tags prévias.Extender o algoritmo para agir de acordo com esta condição (bigrama para trigrama) irá aumentar a performance..
Para alem de acrescentar a janela de contexto, tambem é necessário fazer o tagger saber onde acaba a frase. 
Um dos principais problemas de taggers trigramas é o facto de uma sequencia de tres tags pode nao aparecer no set de treino tendo por isso probabilidade nula. Para resolver este problema devemos usar as probabilidades bigramas ou unigramas.
8.4.8
Quando o numero de estados é muito extenso o algoritmo Viterbi pode se tornar muito lento.
Uma solução para este aspecto passa por usar a procura direccionada para descodificar. Nesta procura, em vez de guardarmos uma coluna com estados por cada tempo t, guarda-se apenas algumas hipoteses de estados para esse instante.
8.4.9
A melhor pista para adivinhar a parte-de-discurso a que corresponde uma palavra desconhecida é a morfologia. O uso de letras maiusculas ou sufixos é um dos aspetos a ter em conta quando se lida com este tipo de palavras.

8.5
O modelo de Markov de máxima entropia é o nome que se dá ao aplicar regressao logistica a uma sequencia de palavras. Apesar da regressão logistica nao ser um modelo logistico, podemos a aplicar sucessivamente em diferentes palavras, usando a classe assignada a palavra antes como parametro na classificação da próxima. Utilizando este modelo, podem ser acrescentadas caracteristicas para melhor a sua precisão.
8.5.1
No modelo de Markov de maxima entropia podem ser acresentadas condições de observações de palavras vizinhas, palavras mais antigas ou ate mesmo outras condições. 
Outra caracteristica que pode ser acrescentada trata-se da forma das palavras. Com esta caracteristica podem se representar padroes abstratos de letras em palavras.
8.5.2
A maneira mais simples de tornar a regressao logistica num modelo sequencial é classificar cada palavra da esquerda para a direita, fazendo um classificação "hard" na primeira palavra e uma decisao "hard" nas proximas sucessivamente. Este algoritmo é conhecido por "greedy (ganancioso). O problema deste algoritmo prende-se no facto de as decisoes serem tomadas sem considerar decisoes futuras.
A melhor solução é efetuada atraves da utilização do algoritmo de Viterbi como no modelo oculto de Markov. 

8.6
O unico problema com os dois modelos apresentados previamente é o facto de ambos correrem exclusivamente da esquerda para a direita. seria útil poder tomar uma decisao numa palavra tendo em conta uma tag de uma ou duas palavras a frente. Esta caracteristica denominada de bidirecionalidade pode ser implementada alterando para um modelo chamado de campo aleatório condicional. Este modelo calcula as probabilidades para todas as sequencias de tags tornando-o um modelo bastante lento. O metodo de Stanford tagger tambem pode ser usado fazendo multiplas passagens pelas sequencias.

Exercises
8.1
1. Atlanta NNP
2. dinner NN
3. have VBP
4. can MD






