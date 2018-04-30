
// Classe usada para avaliar as condicoes do fim de jogo
public class EndGame {
	public int tamanho;
	public int[][] tabuleiro;
	
	public EndGame(int tamanho, int[][] tabuleiro){
		// Construtor
		this.tamanho = tamanho;
		this.tabuleiro = tabuleiro;
	}
	
	public boolean fim(int[][] tab){
		// Verifica se existem n�meros iguais ao lado uns dos outros retornando um boleano
		
		Plays objeto = new Plays(tab, tamanho); // Objeto da classe Plays
		for(int i=0; i<tamanho; i++){
			for(int j=0; j<tamanho; j++){
				if(objeto.verVizinhos(i, j) && tab[i][j] !=0){
					return false;
					
				}
			}
		}
		return true;
	}
	
	public boolean ganhou(int[][] tab){
		//Se algum numero no array tab for diferente de 0 (que corresponde a um botao que desapareceu) 
		//retorna false, ou seja o jogo pode nao ter terminado
		
		for(int i=0; i<tamanho; i++){
			for(int j=0; j<tamanho; j++){
				if(tab[i][j] != 0){
					return false;
				}
			}
		}
		return true;
	}
	
	public int score(int x){
		//Recebe como argumento o numero de cores diferentes no tabuleiro inicial
		//
		//Calcula o score do utilizador calculando o numero de "quadrados" que nao foram retirados
		//do tabuleiro de jogo
		
		int cont = 0;
		for(int i=0; i<tamanho; i++){
			for(int j=0; j<tamanho; j++){
				if(tabuleiro[i][j] != 0){
					cont++;		//numero de peças presentes no tabuleiro
				}
			}
		}
		return (tamanho*tamanho-cont)*x;		//equacao do score do utilizador
	}
}
