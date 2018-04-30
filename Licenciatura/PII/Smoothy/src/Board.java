
import java.util.Random;

public class Board{
	
	// Esta classe cria uma grelha quadrada com numeros aleatorios
	
	public int tamanho;  
	public int[][] grelha; 	
	
	public Board(int tamanho){     
		// Este construtor inicializa o tamanho e usa-o para a dimensao da grelha
		
		this.tamanho = tamanho;
		this.grelha = new int[tamanho][tamanho];
	}
		
	public void construirGrelha(int C, int S){
		// Este metodo vai prencher cada espaco do array de arrays Grelha com um numero aleatorio
		
		Random r = new Random(S); 				// Variavel S corresponde � seed do tabueiro
		for(int i=0; i<tamanho; i++){			
			for(int j=0; j<tamanho; j++){
				grelha[i][j] = r.nextInt(C)+1;
				}
			}
		}
	}
