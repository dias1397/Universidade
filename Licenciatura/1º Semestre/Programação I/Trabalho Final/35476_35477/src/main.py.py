from tkinter import *
import random
import copy

global tab,tam

#Criar Tabuleiro Aleatório
def tabuleiro():
    global tam, tab
    tab = []    #Inicializa a lista onde vao ser guardados os numeros do tabuleiro (1 a 6)
    for linha in range(tam):
        tab.append ([])     #Transforma tab numa lista de listas
        for coluna in range(tam):
            tab[linha].append(random.randint(1,6))

#Visualizar o Tabuleiro Criado
def ver_tab(tab):
    for i in range(len(tab)):
        print(' ')
        for j in range(len(tab)):
            #Devolve todos os numeros de cada lista na lista tab na mesma linha
            #Ex.: tab[[1,2,..],[3,4,..],...] --> 1 2 ... -> 1ªlinha 3 4 ... -> 2ªlinha
            print((tab[i][j]), end=" ")     


        

#Algoritimo: Carregar Tabuleiro a partir de um ficheiro .txt
def carregar_tabuleiro():
    global tab,tam    
    arquivo = open('tabuleiro.txt','r')
    #Abre o ficheiro .txt de onde se pretende retirar o tabuleiro
    c=0
    b=0
    lista = arquivo.readlines()
    #Cria uma lista de listas com cada linha de um ficheiro numa lista
    tam = len(lista)
    tabuleiro()
    for i in range(len(lista)-1):
        for item in lista[i]:
            if (item != '\n'):
                #Apenas os elementos diferentes de \n neste caso os numeros 
                #sao transferidos para a variavel global tab.
                tab[b][c] = int(item)
            c+=1
        c = 0
        b +=1
    ver_tab(tab)


        
#Algoritimo: Gerar Tabuleiro
def gerar_tabuleiro():
    global tab, tam
    
    def tamanho():
        try:
            print('O tamanho minimo do tabuleiro é 3')
            x= int(input('Insira o tamanho do tabuleiro:'))
            return x
        except ValueError:
            print('Não insiriu o valor correcto')
            return False

    tam = tamanho()
    while (tam==False) or (int(tam)<3):
        tam = tamanho()
    tam =int(tam)

        
    tabuleiro()     #Funçao que devolve um tabuleiro com numeros aleatorios
    #Quantidade de números a alterar no tabuleiro aleatorio
    n_mudar=(tam*tam)//3
    
    # Mudar o número da casa ao lado:
    for i in range(int(n_mudar)):
    # Seleciona as coordenadas(x,y) onde se muda os numéros
        x = random.randint(1, tam-2)
        y = random.randint(1, tam-2)

        #Escolhe aleatoriamente as direções do numero que vao ser alterados
        direcao = random.randint(0, 3)
        
        if direcao == 0: # Muda a esquerda e a de cima
            tab[x-1][y] = tab[x][y]
            tab[x][y-1] = tab[x][y]
        elif direcao == 1: # Muda a direita e a de baixo
            tab[x+1][y] = tab[x][y]
            tab[x][y+1] = tab[x][y]
        elif direcao == 2: # Muda a diraita e a de cima
            tab[x][y-1] = tab[x][y]
            tab[x+1][y] = tab[x][y]
        else: # Muda a esquerda e a de baixo
            tab[x][y+1] = tab[x][y]
            tab[x-1][y] = tab[x][y]
    ver_tab(tab)

    

#Pricipal Algoritimo do Jogo
def jogada(tabuleiro,x, y, antigo, novo):

    #Se o numero a mudar for igual ao antigo nao retorna nada
    if antigo==novo or tabuleiro[x][y]!=antigo:
        return
    
    #Atribui o valor desejado à variavel que satisfaça as condiçoes acima
    tabuleiro[x][y] = novo
    if x>0:
        # Funçao recursiva à direita 
        jogada(tabuleiro,x - 1, y, antigo, novo)
    if x<(tam-1):
        # Funçao recursiva à esquerda 
        jogada(tabuleiro,x + 1, y, antigo, novo)
    if y>0:
        # Funçao recursiva a baixo 
        jogada(tabuleiro,x, y - 1, antigo, novo)
    if y<(tam-1):
        # Funçao recursiva a cima 
        jogada(tabuleiro,x, y + 1, antigo, novo)

#Verifica se os numeros introduzidos sao o 1,2,3,4,5,6
def numero_valido():
    global tab
    l=['1','2','3','4','5','6']
    n =input("Valor:")
    while type(n) != int:
        if (str(n) in l) and (int(n) != int(tab[0][0])):
            n=int(n)
        else:
            if str(n) in l:
                print('Não pode escolher o mesmo número')
            else:
                print('Valor fora do intervalo [1,6]')
            n=input("Valor:")
    return n        

#Principal algoritmo para o modo IA
def ia():
    global tab
    def melhor_area(numeros):       #argumento é uma lista com os numeros que o IA pode jogar
        global tam,tab
        comb = dict()       #dicionario onde se vai colocar combinaçoes de opçoes
        tab_teste = copy.deepcopy(tab)      #copia o tabuleiro original para um tabuleiro de teste
        for numero in numeros:

            #faz a jogada para os varios elementos da lista numeros
            jogada(tab_teste,(tam-1),(tam-1),int(tab_teste[-1][-1]),numero)

            #muda a area "pintada" para o numero 0 para a seguir ser mais facil de contar
            jogada(tab_teste,(tam-1),(tam-1),int(tab_teste[-1][-1]),0)

            #Adiciona ao dicionario o numero de vezes que o numero aparece
            #Ex.: comb={'1'=3, '2'=4} ->numero um aparece tres vezes e o dois quatro vezes
            #logo o IA vai jogar com o numero 2
            comb[str(numero)] = (contar(tab_teste,0))
            #reinicia o tabuleiro de teste para prosseguir o for para outro numero da lista
            tab_teste = copy.deepcopy(tab)      
        return int(max(comb, key=comb.get))     #Retorna o numero que é repetido mais vezes

    #Funçao que conta quantas vezes um numero aparece no tabuleiro
    def contar(tabuleiro,numero):
        contador=0
        for linha in tabuleiro:
            contador += linha.count(numero)
        return contador

    #Jogo
    n = numero_valido()     #Valor jogado por utilizador
    while int(n) == int(tab[-1][-1]):
        print('Numero jogado pelo CPU, introduza outro')
        n = numero_valido()
    jogada(tab,0,0,int(tab[0][0]),int(n))
    
    cpu=[1,2,3,4,5,6]
    cpu.remove(int(n))
    #lista cpu torna-se nos numeros que o IA vai poder jogar
    jogada(tab,(tam-1),(tam-1),int(tab[-1][-1]),melhor_area(cpu))
    
    
#Funçao que verifica se o jogo terminou ou nao
def fim(x):
    global tam
    if x == 'solo':     #Fim único jogador
        for linha in range(tam):
            for coluna in range(tam):
                #Procura se existem dois numeros diferentes no tabuleiro
                #Se encontrar mais que um numero diferente no tabuleiro o jogo nao terminou
                if tab[linha][coluna]!=tab[0][0]:
                    return False
    elif x == 'ia':     #Fim jogo VS IA
        lista=[]
        for linha in range(tam):
            for coluna in range(tam):
                if tab[linha][coluna] not in lista:
                    lista.append(tab[linha][coluna])
        #Se for encontrado tres ou mais numeros diferentes jogo nao terminou
        if len(lista)>=3:
            return False
        else:       #se o jogo terminou este else vai verificar quem ganha
            sum1=0  #pontos Jogador 1
            sum2=0  #pontos IA
            jogador1=int(tab[0][0])
            ia=int(tab[-1][-1])
            for linha in range(tam):
                for coluna in range(tam):
                    if tab[linha][coluna]==jogador1:
                        sum1 += 1
                    else:
                        sum2 += 1
            if sum1>sum2:
                print(' ')
                print('GANHOU ',sum1,' a ',sum2)
            elif sum2>sum1:
                print(' ')
                print('PERDEU ',sum1,' a ',sum2)
            else:
                print(' ')
                print('EMPATE ',sum1,' a ',sum2)
    else:
        print('Erro')
        
        

def solo_carregar():    #Motor de jogo (Unico jogador, Carregar tabuleiro)
    carregar_tabuleiro()
    jogadas=tam*2
    n=0
    #Corre o jogo ate a funçao fim der o jogo como terminado
    while fim('solo')==False and jogadas!=0:       
        print(" ")
        print('Tem',jogadas,'jogadas restantes')
        n=numero_valido()
        jogada(tab,0,0,int(tab[0][0]),int(n))
        jogadas-=1
        ver_tab(tab)
        
    if jogadas==0 and fim('solo')==False:
        print(' ')
        print('Perdeu')
    else:
        print(' ')
        print('Ganhou')
    

def solo_gerar():       #Motor de jogo (Unico jogador, Gerar tabuleiro)
    gerar_tabuleiro()
    jogadas=tam*2
    n=0
    #Corre o jogo ate a funçao fim der o jogo como terminado
    while fim('solo')==False and jogadas!=0:
        print(" ")
        print('Tem',jogadas,'jogadas restantes')
        n=numero_valido()
        jogada(tab,0,0,int(tab[0][0]),int(n))
        jogadas-=1
        ver_tab(tab)

    if jogadas==0 and fim('solo')==False:
        print(' ')
        print('Perdeu')
    else:
        print(' ')
        print('Ganhou')
    
def ia_carregar():      #Motor de jogo (VS IA, Carregar tabuleiro)
    carregar_tabuleiro()
    #Corre o jogo ate a funçao fim der o jogo como terminado
    while fim('ia') == False:
        print(" ")
        ia()
        ver_tab(tab)

def ia_gerar():     #Motor de jogo (VS IA, Gerar tabuleiro)
    gerar_tabuleiro()
    #Corre o jogo ate a funçao fim der o jogo como terminado
    while fim('ia') == False:
        print(" ")
        ia()
        ver_tab(tab)



def menu():     #Menu inicial
    global start, start2, saida, ajuda
    start = Button(root, text = "Único Jogador", command=opcoes_solo)
    start2 = Button(root, text = "IA", command=opcoes_ia)
    saida = Button(root, text = "Sair", command=root.destroy)
    #Tamanho dos botoes
    start.config(height = 1, width = 15)
    start2.config(height = 1, width = 15)
    saida.config(height = 1, width = 15)
    
    start.pack()
    start2.pack()
    saida.pack()

def opcoes_solo():      #Menu opçao 1 jogador
    global start4, start5, voltar
    start.destroy()
    start2.destroy()
    saida.destroy()
    start4 = Button(root, text = "Carregar Tabuleiro", command=solo_carregar)
    start5 = Button(root, text = "Gerar Tabuleiro", command=solo_gerar)
    voltar = Button(root, text ="Voltar atrás", command=voltar_a)
    #Tamanho dos botoes
    start4.config(height = 1, width = 15)
    start5.config(height = 1, width = 15)
    voltar.config(height = 1, width = 15)
    
    start4.pack()
    start5.pack()
    voltar.pack()

def opcoes_ia():        #Menu opçao VS CPU
    global start4, start5, voltar
    start.destroy()
    start2.destroy()
    saida.destroy()
    start4 = Button(root, text = "Carregar Tabuleiro", command=ia_carregar)
    start5 = Button(root, text = "Gerar Tabuleiro", command=ia_gerar)
    voltar = Button(root, text ="Voltar atrás", command=voltar_a)
    #Tamanho dos botoes
    start4.config(height = 1, width = 15)
    start5.config(height = 1, width = 15)
    voltar.config(height = 1, width = 15)
    
    start4.pack()
    start5.pack()
    voltar.pack()
    
def voltar_a():
    start4.destroy()
    start5.destroy()
    voltar.destroy()
    menu()
    
root = Tk()
menu()
root.geometry('200x100'.format(300, 300))   #Tamanho do menu
root.mainloop()
    
