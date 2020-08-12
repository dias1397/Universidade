	.data
nome_ficheiro:.space 64
vig:	.ascii ".vig"
txt:	.ascii ".txt"
fic:	.space 4
chave:	.space 512
frase:	.space 512
escrever:.space 512
string: .asciiz "File name: "
string_2:.asciiz "Chave: "
encriptado:.asciiz "Encriptado.vig"
desencriptado:.asciiz "Desencriptado.txt"
mensagem:.asciiz "O ficheiro nao existe \n"
	.text
			
#########################################################################################
#	RECEBER INPUT DO NOME DO FICHEIRO						#
#	$s1 - endereço nome do ficheiro						#
#########################################################################################

input_file_name:	#receber input
	
    	la $a0,string                
    	li $v0,4                       
    	syscall

	la $a0, nome_ficheiro
	li $a1, 50		#caracteres a ler
	li $v0, 8
	syscall
		
	move $s1, $a0		#guarda a primeira posiçao do nome do ficheiro
	
#########################################################################################
#	RECEBER INPUT DA PALAVRA CHAVE							#
#	$s2 - endereço palavra chave							#
#########################################################################################

input_palavra_chave:

	la $a0,string_2                
    	li $v0,4                       
    	syscall
	
	la $a0, chave
	li $a1, 50		#caracteres a ler
	li $v0, 8
	syscall
	
	move $s2, $a0


#########################################################################################
#	SALTA PARA AS FUNÇOES QUE VÃO RETIRAR \n					#
#	DO NOME DO FICHEIRO E DA PALAVRA CHAVE						#
#########################################################################################

remove:
	move $a0, $s1	
	jal fim_de_frase	#nome do ficheiro
	nop
	
	move $a0, $s2
	jal fim_de_frase	#palavra chave
	nop
	j fopen
	nop

#########################################################################################
#	FUNCAO QUE PROCURA NO ENDEREÇO $a0 O CARACTER \n E COLOCA O A 0			#
#########################################################################################

fim_de_frase:				# procurar \n do nome do ficheiro do user
	lb $t0, 0($a0)			# Carrega a letra no endere�o
	beq $t0, 0x0a, fim_loop		# 0x0a = \n
	nop
	addi $a0, $a0, 1
	j fim_de_frase
	nop
fim_loop:
	sb $0, 0($a0)			# Substitui o caracter \n por 0
	jr $ra
	nop


#########################################################################################
#	ABRE FICHEIRO EM MODO DE LEITURA E LE O CONTEUDO DESSE FICHEIRO			#
#########################################################################################

fopen:
	la $a0, nome_ficheiro
	li $a1, 0		# Argumento que indica o modo de abertura do ficheiro
	jal abrir_ficheiro	# Funçao que abre o ficheiro para leitura
	nop
	beq $v0, -1, erro
	nop
	jal ler_ficheiro	# Funçao que le o ficheiro para frase
	nop
	jal fechar_ficheiro	# Fecha ficheiro
	nop

#########################################################################################
#	CARREGA OS ENDERENÇOS DOS ESPAÇOS DE MEMORIA PARA A FRASE, CHAVE E O CODIGO	#
#########################################################################################
	
	la $t4, frase		# Onde se vai guardar o que esta escrito no ficheiro
	la $t5, chave		# Onde esta guardado a palavra chave
	la $t6, escrever	# Onde irá ser guardado a frase codificada


#########################################################################################
#	CODIGO QUE CHAMA A FUNÇAO QUE CALCULA O COMPRIMENTO DA FRASE A SER CODIFICADA	#
#########################################################################################

	li $t1, 0
	move $a0, $t4		# $t4 = endereço de memoria da frase contida no ficheiro
	j comprimento
	nop
	

#########################################################################################
#	FUNÇAO QUE CALCULA O NUMERO DE CARACTERES PRESENTES A PARTIR DO ENDEREÇO EM $a0	#		
#########################################################################################

comprimento:
	lb $t0 , 0($a0)			# Carrega o caracter no respetivo endereço para $t0
	beq $t0, 0x0a, fim_comp		# Se o caracter for \n a contagem chegou ao fim
	nop
	beq $t0, $0, fim_comp
	nop
	addi $t1, $t1, 1		# Contador de caracteres
	addi $a0, $a0, 1		# Avança nos endereços
	j comprimento
	nop
fim_comp:
	add $v0, $0, $t1		# Coloca o resultado na variavel de retorno da funçao	
	
	move $s3, $v0			# Em $s3 vai ficar guardado o comprimento da frase
	
##########################################################################################
#	CODIGO QUE PROLONGA A PALAVRA CHAVE DE FORMA A FICAR DO MESMO TAMANHO QUE A FRASE#
##########################################################################################

	li $t1, 0
	move $a1, $t5			# Dois argumentos que serão o primeiro endereço de onde esta
	move $a0, $t5			#guardada a palavra chave em memoria
	j aumentar
	nop
	
#########################################################################################
#	FUNÇAO QUE REPETE A PALAVRA CHAVE ATE FICAR DO TAMANHO DA FRASE			#
#########################################################################################

aumentar:
	beq $t1, $s3, fim_aum		# Se o contador $t1 for igual ao comprimento da frase 
	nop				#guardado em $s3 o ciclo chegou ao fim
	lb $t0 , 0($a0)			
	beq $t0, $0, adicionar		# Se o caracter na palavra chave for $0 significa que já nao há caracteres 
	nop		#mas ha espaços a prencher logo salta-se para adicionar de modo a carregar novamente o endereço
	sb $t0, 0($a1)			# Como nunca se faz reset a $a1 vai se adicionando os caracteres neste endereço
	addi $t1, $t1, 1		# Contadpr de tamanho atual da palava chave
	addi $a1, $a1, 1
	addi $a0, $a0, 1
	j aumentar
	nop
adicionar:
	la $a0, chave			# Faz reset, de modo a voltar ao primeiro endereço da palavra chave
	j aumentar
	nop
fim_aum:


#########################################################################################
#	CODIGO QUE TRANSFORMA A FRASE E A PALAVRE CHAVE EM CARACTERES MAIUSCULOS	#
#########################################################################################

	move $a0, $t4			# Endereço da frase
	jal maiusculas
	nop
	move $a0, $t5			# Endereço da palavra chave
	jal maiusculas
	nop
	j ponto1
	nop

#########################################################################################
#	FUNÇAO QUE TRANSFORMA UM CONJUNTO DE CARACTERES EM CARACTERES MAIUSCULOS	#
#########################################################################################

maiusculas:
	add $t1, $0, $0
	lb $t1, 0($a0)		# Carrega o byte corresponndente ao endereço em $a0
	beq $t1, $0, fim_mai	# Se o byte for 0 o algoritmo chega ao fim
	nop
	bge $t1, 0x61, faz	# Se for maior que 61 (a) significa que é uma letra
	nop			#minuscula logo salta para fazer conversao
	addi $a0, $a0, 1	# Avança no endereço
	j maiusculas
	nop
faz:
	addi $t1, $t1, -32	# Retira 32 unidades para corresponder a uma letra maiuscula
	sb $t1, 0($a0)		# Guarda a nova letra no endereço
	addi $a0, $a0, 1
	j maiusculas		# Volta a funçao principal
	nop
fim_mai:
	jr $ra
	nop


#########################################################################################
#	DESCOBRIR UM PONTO NO FICHEIRO							#
#########################################################################################

ponto1:	
	move $a0, $s1		# $a0 = primeiro endereço nome do ficheiro
	la $t0, fic		# $t0 = endereço de espaço a preencher pela extensao
ponto:				# procura um ponto no nome do ficheiro
	lb $t1, 0($a0)	
	beq $t1, 0x2e, extensao	# 0x2e representa um ponto na tabela ASCII.
	nop			# e salta para a proxima função quando encontra um ponto
	addi $a0, $a0, 1
	j ponto
	nop

#########################################################################################
#	GUARDA NO ENDEREÇO EM $T0 A EXTENSAO DO FICHEIRO (.TXT OU .VIG)			#
#	PARA DEPOIS COMPARAR COM AS EXTENSOES JA GUARDADAS EM MEMORIA			#
#########################################################################################

extensao:
	lb $t1, 0($a0)		
	beq $t1, 0x00, compara_extensao		# Quando chega ao fim do nome do ficheiro
	nop					# salta para a funçao que compara
	sb $t1, 0($t0)		# Guarda a partir de $t0 os ultimos 4 caracteres 
	addi $a0, $a0, 1	#do nome do ficheiro
	addi $t0, $t0, 1
	j extensao
	nop
	
#########################################################################################
#	FUNÇAO QUE COMPARA WORDS QUE CONTEM EXTENSOES DE FICHEIROS			#
#########################################################################################
		
compara_extensao:
	la $a1, fic		# Extensao ficheiro do utilizador
	la $a2, vig		# Primeiro endereço extensao .vig
	la $a3, txt		# Primeiro endereço extensao .txt
	lw $t1, 0($a1)		
	lw $t2, 0($a2)		# 3 instruçoes que carregam as respetivas words
	lw $t3, 0($a3)
	beq $t1, $t3, main_encripta	# Encripta se extensão for igual a .txt
	nop
	beq $t1, $t2, main_desencripta	# Desencripta se extensão for igual a .vig
	nop	


#########################################################################################
#	FUNÇAO MAIN DO PROCESSO DE ENCRIPTAÇÃO DO FICHEIRO (RECURSIVA)			#
#########################################################################################

main_encripta:
	lb $a0, 0($t4)		# Load do caracter da frase
	lb $a1, 0($t5)		# Load do caracter da palavra chave
	
	beq $a0, 0x0a, escreve_encriptado	# Se o caracter da frase for \n significa que o processo de incriptaçao
	nop					#chegou ao fim
	beq $a0, $0, escreve_encriptado		# Se o caracter da frase for 0 significa que o processo de incriptaçao
	nop					#chegou ao fim
	jal encripta
	nop
	add $a0, $a0, $v0	# Caracter original da frase vai ser somado com o valor da deslocaçao	
	sb $a0, 0($t6)		# Guarda o caracter no endereço do espaço "escrever"
	
	addi $t4, $t4, 1	# Avançar um valor em todos os endereços
	addi $t5, $t5, 1
	addi $t6, $t6, 1

	j main_encripta
	nop
	
#########################################################################################
#	FUNÇAO PRINCIPAL QUE ENCRIPTA UM CARACTER $a0 ATRAVES DE UM CARACTER $a1	#
#########################################################################################

encripta:
	add $t1, $a1, $a0	# Soma-se o valor dos dois caracteres
	addi $t1, $t1, -65	# Retira-se 65 pois a primeira letra (A) tem o valor 65
	ble $t1, 90, fim_2	# Se for overflow, ou seja um caracter maior que 90 (Z)
	nop			#temos de retirar o comprimento do alfabeto uma vez 
	addi $t1, $t1, -26	
fim_2:
	sub $v0, $t1, $a0	# Em $v0 ficará o valor de deslocaçao da encriptaçao
	jr $ra
	nop
	
#########################################################################################
#	FUNÇAO QUE CRIA UM NOVO FICHEIRO E ESCREVE NO MESMO				#
#########################################################################################
	
escreve_encriptado:
	la $a0, encriptado	# Carrega o endereço com o nome e extensao do novo ficheiro
	la $a1, 1		# Abrir ficheiro em modo de escrita
	jal abrir_ficheiro
	nop
	move $a2, $s3		# Numero de caracteres a escrever vai ser o nº de caracteres da frase inicial
	jal escrever_ficheiro
	nop
	jal fechar_ficheiro
	nop
	
	j fim
	nop


#########################################################################################
#	FUNÇAO MAIN DO PROCESSO DE ENCRIPTAÇÃO DO FICHEIRO (RECURSIVA)			#
#########################################################################################

main_desencripta:
	lb $a0, 0($t4)			# Load do caracter da frase
	lb $a1, 0($t5)			# Load do caracter da palavra chave
	
	beq $a0, 0x0a, escreve_desencriptado	# Se o caracter da frase for \n significa que o processo de incriptaçao
	nop					#chegou ao fim
	beq $a0, $0, escreve_desencriptado		# Se o caracter da frase for 0 significa que o processo de incriptaçao
	nop					#chegou ao fim
	jal desencripta
	nop
	add $a0, $a0, $v0	# Caracter original da frase vai ser somado com o valor da deslocaçao
	sb $a0, 0($t6)		# Guarda o caracter no endereço do espaço "escrever"
	
	addi $t4, $t4, 1	# Avançar um valor em todos os endereços
	addi $t5, $t5, 1
	addi $t6, $t6, 1
	
	j main_desencripta
	nop

#########################################################################################
#	FUNÇAO PRINCIPAL QUE DESENCRIPTA UM CARACTER $a0 ATRAVES DE UM CARACTER $a1	#
#########################################################################################

desencripta:
	sub $t1, $a0, $a1	#soma-se o valor das duas letras
	addi $t1, $t1, 26
	addi $t1, $t1, 65
	ble $t1, 90, fim_3	#se for overflow, maior que 90
	nop			#temos de retirar o comprimento do total de letras 
	addi $t1, $t1, -26	#uma vez
fim_3:	
	sub $v0, $t1, $a0
	jr $ra
	nop

#########################################################################################
#	FUNÇAO QUE CRIA UM NOVO FICHEIRO E ESCREVE NO MESMO				#			
#########################################################################################
	
escreve_desencriptado:
	la $a0, desencriptado	# Carrega o endereço com o nome e extensao do novo ficheiro
	la $a1, 1		# Abrir ficheiro em modo de escrita
	jal abrir_ficheiro
	nop
	move $a2, $s3		# Numero de caracteres a escrever vai ser o nº de caracteres da frase inicial
	jal escrever_ficheiro
	nop
	jal fechar_ficheiro
	nop	
		
	j fim
	nop
	
	
	
#########################################################################################
#	MANIPULAÇÃO DE FICEHIROS							#
#	-ABRIR FICHEIRO PARA LEITURA OU ESCRITA						#
#	-LER CONTEUDO DE FICHEIRO							#
#	-ESCREVER NUM FICHEIRO 								#
#########################################################################################

abrir_ficheiro:	
	
    	#move $a1, $s0
    	li $a2, 0
    	li $v0, 13
    	syscall
    	move $s6, $v0
    	jr $ra
    	nop
    	
ler_ficheiro:
	#ler
	move $a0, $s6
	la $a1, frase
	li   $a2, 512
	li $v0, 14
	syscall
	jr $ra
	nop
	
escrever_ficheiro:
	#escrever
    	move $a0, $s6
    	la $a1, escrever
    	#li $a2, 512	#numero de bytes a ler
    	li $v0, 15
    	syscall
    	
fechar_ficheiro:
    	#close
    	move $a0, $s6
    	li $v0, 16
    	syscall
    	jr $ra
    	nop
    	
#########################################################################################
#	FUNÇAO QUE MOSTRA NA CONSOLA UMA MENSAGEM DE ERRO CASO O FICHEIRO NAO EXISTA	#
#########################################################################################

erro:
	la $a0, mensagem                
    	li $v0, 4                     
    	syscall
    	
    	j input_file_name
	nop

#########################################################################################
#	FIM DO PROGRAMA									#
#########################################################################################

fim:
	li $v0, 10                      # Sai do programa
	syscall	
