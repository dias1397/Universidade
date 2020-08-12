
import java.awt.FontFormatException;
import java.io.IOException;
import javax.swing.JOptionPane;

public class Body {
	public int tam, seed, cores;
	
	public int tryCatch(int max, int min, String abc){
		// Encontra erros na introducao de valores fora dos intervalos desejados(max, min)
		
		String x;
		while(true){
			try{
				x = JOptionPane.showInputDialog(null,abc,"Smoothy", JOptionPane.PLAIN_MESSAGE);
				if(x==null){
					System.exit(0);
				}else{
					if(Integer.parseInt(x)>max || Integer.parseInt(x)<min){
						throw new NumberFormatException();
					}
				}				
				break;
			}catch(NumberFormatException e){
				JOptionPane.showMessageDialog(null, "Valor inserido incorrecto" );
			}
		}
		
		return Integer.parseInt(x);
	}
	
	public Body(){
		//Construtor que inicializa os parametros de jogo
		
		tam = tryCatch(100,2, "Insira o tamanho do tabuleiro:     (2-100)");
		cores = tryCatch(6,3, "Insira o n�mero de cores:     (3-6)");
		seed = tryCatch(Integer.MAX_VALUE, 0, "Insira a seed:");		
	}
	
	public static void main(String[]args) throws InterruptedException, IOException, FontFormatException{
		//principal metodo do programa

		Menu objetoMenu = new Menu();		//cria um objeto da classe menu
		objetoMenu.mainMenu();				//chama o menu principal da classe menu
		while(true){					//loop de jogo
			if(objetoMenu.scr){			//opcao selecionada no menu é score
				Score scr = new Score();
				scr.showScore();		//mostra os recordes
				objetoMenu.scr=false;	//variavel scr colocada a falso para esperar nova acçao do utilizador
			}
			if(objetoMenu.verdade){		//Quando "new game" é clicado retorna um boleno em que indica a esta funcao para executar o algoritimo
				objetoMenu.menu.setVisible(false);
				Body objetoBody = new Body();
				Board objetoBoard = new Board(objetoBody.tam);
				objetoBoard.construirGrelha(objetoBody.cores,objetoBody.seed);
				//constroi uma grelha com o input cores e seed introduzido pelo utilizador
				int[][] tab = objetoBoard.grelha;		//Copia o tabuleiro criado para a tab, onde o jogo se ira decorrer

				//Criaçao de objetos de outras classes com os parametros introduzidos pelo utilizador
				EndGame objetoEndGame = new EndGame(objetoBody.tam, tab);
				Plays objetoPlays = new Plays(tab,objetoBody.tam);
				Window objetoWindow = new Window(objetoBody.tam);

				objetoWindow.addPanel();			//adicionar jPannel à janela
				objetoWindow.buttonStart(tab);		//adicionar os botoes
				objetoWindow.janela(objetoEndGame.score(objetoBody.cores));		//colocar a janela no ecran
				
				int[] b = new int[2];		//variavel que vai receber as coordenadas do botao carregado
				int x, y;
				do{
					while (true){
						if(objetoWindow.verdade){				//se isto for true significa que ocorreu uma acçao
							b = objetoWindow.valButton();		//o array b vai ficar com as coordenadas carregadas
							x  = b[0];
							y = b[1];
							objetoPlays.jogada(x,y);			//faz a jogada a partir das coordenadas selecionadas
							objetoWindow.item.setText("SCORE: "+ objetoEndGame.score(objetoBody.cores));
							//mostra o score na janela
							break;
						}
						Thread.sleep(0);		//impede que o ciclo while se repita demasiado rapido e que pare de funcionar
					}
					objetoWindow.buttonColor(tab);		//altera a cor dos botoes consoante o novo tabuleiro apos a jogada
					objetoWindow.verdade = false;		//recoloca a variavel verdade a falso para poder detectar mais acçoes
				}while(objetoEndGame.fim(tab) == false);	
				//ciclo apenas termina se nao houverem botoes na janela ou nao houver jogadas possiveis
				
				if(objetoEndGame.ganhou(tab)){
					JOptionPane.showMessageDialog (null, "Ganhou" + "\n" + "SCORE: "+ objetoEndGame.score(objetoBody.cores), "Fim do jogo",  JOptionPane.PLAIN_MESSAGE);
					//mensagem disponibilizada apenas se o utilizador eliminar todos os botoes da janela
				}else{
					JOptionPane.showMessageDialog (null, "Perdeu" + "\n" + "SCORE: "+ objetoEndGame.score(objetoBody.cores), "Fim do jogo",  JOptionPane.PLAIN_MESSAGE);
					//mensagem disponibilizada senao eliminou todos os botoes mas ja nao ha jogadas possiveis
				}
				
				Score objetoScore = new Score();
				objetoScore.record(objetoEndGame.score(objetoBody.cores));
				//escreve no ficheiro dos recordes a nova pontuaçao caso seja recorde
				objetoScore.showScore();
				
				objetoWindow.window.dispose();
				//faz desaparecer a janela
			}
			
			objetoMenu.verdade=false;		//mete a variavel verdade em false para nao decorrer o codigo "new game"
			objetoMenu.menu.setVisible(true);
		}
		
		
		
	}
}
