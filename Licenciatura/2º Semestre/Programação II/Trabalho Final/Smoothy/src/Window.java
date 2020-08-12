
import java.awt.Color;
import java.awt.ComponentOrientation;
import java.awt.FontFormatException;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.*;

public class Window implements ActionListener {

	public int tam, x=-1, y=-1, cont=0;
	public JFrame window =  new JFrame();	
	public JPanel panel;
	public JMenu item, itemMenu;
	public JButton[][] botoes;
	public boolean verdade, exit=true;
	
	public Window(int tam){
		//construtor da classe
		
		this.tam = tam;
		botoes = new JButton[tam][tam];		
		//Inicializa a dimensao de array de arrays de botoes para a parte grafica do tabuleiro
	}
	
	public void color(int x, JButton bt){
		if(x==0){
			bt.setVisible(false);
			//se no tabuleiro tiver um numero zero, na respetiva posi�ao o bot�o ficar� nao visivel
			//como se tivesse sido apagado do tabuleiro
			
		}else{
			bt.setVisible(true);	
			//Quando um botao "cai" numa posi�ao onde na jogada anterior estava um botao nao visivel
			//tem de se tornar visivel sen�o nao sera visivel na proxima jogada, apesar de estar presente
			}
		if(x==1){
			bt.setBackground(Color.lightGray);
		}
		if(x==2){
			bt.setBackground(Color.cyan);
		}
		if(x==3){
			bt.setBackground(Color.green);
		}
		if(x==4){
			bt.setBackground(Color.red);
		}
		if(x==5){
			bt.setBackground(Color.yellow);
		}
		if(x==6){
			bt.setBackground(Color.orange);
		}
	}
	
	public void buttonStart(int[][] tab){
		//metodo para iniciar a parte grafica no tabuleiro (utilizando botoes)
		//
		//este metodo associa a cada posi��o um bot�o com a cor correspondente a cada numero
		
		for(int i=0;i<tam;i++){
			for(int j=0;j<tam;j++){
				botoes[i][j]=new JButton(/*String.valueOf(tab[i][j])*/);
				panel.add(botoes[i][j]);
				botoes[i][j].addActionListener(this);   //a cada bot�o do tabuleiro adiciona-se um actionlistener
				color(tab[i][j], botoes[i][j]);		//a cada botao ser� atribuido uma cor e a visibilidade
				}
			}
		}
	
	public void buttonColor(int[][] tab){
		//altera a cor de todos os botoes consoante o novo tabuleiro
		
		for(int i=0;i<tam;i++){
			for(int j=0;j<tam;j++){
				//btns[i][j].setText(String.valueOf(tab[i][j]));
				color(tab[i][j], botoes[i][j]);
				}
			}
		}
	
	public void addPanel(){
		//adiciona um painel com o gridlayout para serem organizados os botoes numa grelha
		
		panel = new JPanel(new GridLayout(tam, tam, 0, 0));
		window.add(panel);		//adiciona o painel a janela
	}
	
	public void janela(int score) throws FontFormatException, IOException{
		// cria a janela da parte grafica do tabuleiro
		
		
		JMenuBar taskbar = new JMenuBar();		
		//cria uma barra de ferramentas na janela onde ira ser colocado o score do utilizador
		
		item = new JMenu("SCORE: " + score);
		item.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);		//coloca o score a esquerda da barra
		taskbar.add(Box.createHorizontalGlue());
		taskbar.add(item);		//adiciona o score a barra
		window.setJMenuBar(taskbar);		//adiciona a barra a janela
		
		//definicoes da janela
		window.setResizable(true); // Impossibilita de maximizar
		window.pack();		
		window.setBackground(Color.white);
		window.setSize(800, 800);
		window.setLocationRelativeTo(null);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		window.setVisible(true);		
	}
	
	public void actionPerformed(ActionEvent e) {
		//vai verificar qualquer accao feita pelo utilizador
		//retorna a posicao clicada e a que botao corresponde
		
		for (int i = 0; i < tam; i++){
            for (int j= 0; j < tam; j++){
                if (e.getSource().equals(botoes[i][j])){		
                	//sempre que a fonte da accao corresponde a um botsao retorna true
                	//e adiciona as coordenadas do botao a x e y
                	x = i;
                	y = j;
                	verdade = true;		//verificar que houve um botao clicado
                }
            }
        }
     }
	
	public int[] valButton(){
		//usa-se na classe body para come�ar a jogada a partir desta posicao
		
		int[] a = new int[2];
		a[0]= x;
		a[1] = y;
		return a;
		}
}
