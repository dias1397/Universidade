import java.util.ArrayList;

public class Plays {
	
	public int[][] tab;
	public int tamanho;

	public Plays(int[][] a, int b){		//construtor da classe
		tab = a;		//array de arrays que vai respresentar o tabuleiro
		tamanho = b;
	}

	
	public void eliminar(int linha, int coluna, int antigo){
		//Metodo principal das jogadas que consiste numa função recursiva que elimina numeros iguais colados uns aos outros
		//na horizontal e na vertical.
		//O objetivo é usar esta função para colocar com o valor 0 todas as posiçoes que serao eliminadas
		//Recebe como argumentos as coordenadas onde vai começar a eliminação (linha e coluna) e o numero que esta nessa coordenada

		if(antigo == 0 || tab[linha][coluna] != antigo){
			return;
		}
		tab[linha][coluna] = 0;
		if(coluna>0){				//recursiva para a esquerda
			eliminar(linha, coluna-1, antigo);
		}
		if(coluna<tamanho-1){		//recursiva para a direita
			eliminar(linha, coluna+1, antigo);
		}
		if(linha>0){				//recursiva para cima
			eliminar(linha-1, coluna, antigo);
		}
		if(linha<tamanho-1){		//recursiva para baixo
			eliminar(linha+1, coluna, antigo);
		}
	}

	
	public boolean verVizinhos(int linha, int coluna){
		//metodo com a mesma base que o metodo eliminar que tem como funçao verificar se as vizinhanças de uma certa posiçao
		//tem o mesmo numero que a posição em questao (retornando um boleano)

		if(coluna>0){			//verifica para a esquerda
			if(tab[linha][coluna] == tab[linha][coluna-1]){
				return true;
			}
		}
		if(coluna<tamanho-1){	//verifica para a direita
			if(tab[linha][coluna] == tab[linha][coluna+1]){
				return true;
				}
			}
		if(linha>0){			//verifica para cima
			if(tab[linha][coluna] == tab[linha-1][coluna]){
				return true;
			}
		}
		if(linha<tamanho-1){	//verifica para baixo
			if(tab[linha][coluna] == tab[linha+1][coluna]){
				return true;
			}
		}
		return false;
	}

	
	public void baixar(int linha, int coluna){
		//metodo que tem como função baixar uma posiçao se nas coordenadas abaixo nao existir nenhum numero
		//ou seja se na coordenada abaixo estiver atribuido um 0

		while(linha!=0){		//ciclo repetido ate ao argumento recebido i ser 0
			tab[linha][coluna] = tab[linha-1][coluna];		//posiçao fica com o numero que esta na posiçao de cima
			tab[linha-1][coluna] = 0;
			linha--;
		}
	}

	
	public void verParaBaixar(){
		//o metodo procura por todo o tabuleiro um buraco (correspondente ao 0)
		//e sempre que o encontra, caso possivel, chama o metodo baixar 

		for(int i=0; i<tamanho; i++){
			for(int j=0; j<tamanho; j++){
				if(tab[i][j] == 0){
					baixar(i,j) ;
					}
				}
			}
	}


	public boolean verColunaVazia(int coluna){
		//metodo que verifica se uma certa coluna esta vazia ou seja se apenas contem zeros
		//recebe como argumento o numero da coluna em questao e devolve um booleano

		for(int i=0; i<tamanho; i++){
			if(tab[i][coluna] != 0){
				return false;
			}
		}
		return true;
	}


	public int PosicaoDaColunaVazia(ArrayList<Integer> x){
		//metodo retorna a posicao da coluna vazia a ser movida
		
		for(int j=0; j<tamanho; j++){
			if(verColunaVazia(j)==true){
				if(verificarColuna(x,j) == false && j != 0){
					return j;
					}
				}
			}
		return 0;
		}


	public void moverDireita(int a){
		//metodo que move para a direita colunas que tiverem ao seu lado direito colunas vazias
		//recebe como argumento um array que contem as posiçoes das colunas vazias

		if(a!=0){		//se a for diferente de zero significa que existe pelo menos uma coluna que contem apenas zeros
			for(int j=0; j<tamanho; j++){
				tab[j][a] = tab[j][a-1];	//a coluna que contem so zeros toma os valores da coluna que esta do seu lado esquerdo
				tab[j][a-1]=0;				//e a coluna do lado esquerda fica com zeros
			}
		}
	}
	
	public boolean verificarColuna(ArrayList<Integer> x, int j){
		//metodo que recebe como argumento o ArrayList das posi�oes e uma coluna
		//verifica se a coluna ja faz parte das posicoes guardadas retornando um boleano
		
		for(int i=0; i<x.size(); i++){
			int y = x.get(i);
			if(j == y){
				return true;
			}
		}
		return false;
	}

	
	public void jogada(int posy,int posx){
		//metodo principal que executa uma jogada
		//recebe como argumentos as coordenadas onde se iniciara a jogada

		int a, cont=0;
		ArrayList<Integer> x = new ArrayList<Integer>(); //este a ArrayList guaradas as posi�oes das colunas movidas
														 //que por conseguinte corresponde ao contador (cont) 
		
		if(verVizinhos(posy, posx)){
			eliminar(posy,posx,tab[posy][posx]);
			}		
		verParaBaixar();
		a = PosicaoDaColunaVazia(x);
		do{
			if(a!=0){
				cont++;
				x.add(cont);
				}		
			while(a!=0){
				moverDireita(a);
				a--;
				}		
			a = PosicaoDaColunaVazia(x);
			}while(a!=0);
	}
	}
