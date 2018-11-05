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

