
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;

public class Menu implements ActionListener {
	
	public JFrame menu = new JFrame();		//cria uma nova janela para o menu do jogo
	public JButton newGame, scores, sair;
	public boolean verdade=false, scr=false;

	public void newGameButton(){		//cria um botao para iniciar um novo jogo
		ImageIcon icon2 = new ImageIcon("resource/newGame.png");		//encontra a imagem a ser usado no botao
		newGame = new JButton(icon2);		//adiciona a imagem ao botao
		newGame.addActionListener(this);		//adiciona um actionlistener ao botao
		newGame.setContentAreaFilled(false);		//a area de preenchimento do botao fica vazio pois o fundo da imagem e transparente
		newGame.setBorderPainted(false);		//oculta os cotornos do botao
		newGame.setBounds(50, 120, 200, 50);
		menu.add(newGame);		//adiciona o botao a janela
	}
	
	public void scoreButton(){		//cria um botao para ver os resultados
		ImageIcon icon3 = new ImageIcon("resource/score.png");
		scores = new JButton(icon3);
		scores.addActionListener(this);
		scores.setContentAreaFilled(false);
		scores.setBorderPainted(false);
		scores.setBounds(50, 175, 200, 50);
		menu.add(scores);
	}
	
	public void sairButton(){		//cria um botao para sair do jogo
		ImageIcon icon4 = new ImageIcon("resource/sair.png");
		sair = new JButton(icon4);
		sair.addActionListener(this);
		sair.setContentAreaFilled(false);
		sair.setBorderPainted(false);
		sair.setBounds(50, 230, 200, 50);
		menu.add(sair);
	}
	
	public void fundo(){		//personalizar o fundo da janela do menu
		JPanel panel = new JPanel();
		panel.setSize(300, 350);
		panel.setBackground(Color.BLUE);
		panel.setBorder(BorderFactory.createMatteBorder(3, 3, 30, 3, Color.black));		//cria uma fronteira a volta da janela
		ImageIcon icon = new ImageIcon("resource/fundo.png");
		panel.add(new JLabel(icon));
		menu.add(panel);
	}
	
	public void frame(){		//defenicoes da janela
		menu.setSize(300, 325);
		menu.setLocationRelativeTo(null);
		menu.setLayout(null);
		menu.setUndecorated(true);		//oculta a toolbar da janela
		menu.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	
	public void actionPerformed(ActionEvent e) {		//detecta se os botoes do menu foram clicados
		if(e.getSource().equals(sair)){
			System.exit(0);
		}
		if(e.getSource().equals(newGame)){
			menu.setVisible(false);
			verdade=true;
			
		}
		if(e.getSource().equals(scores)){
			scr=true;
		}
	}
	
	public void mainMenu(){		//metodo que cria por completo o menu
		frame();
		newGameButton();
		scoreButton();
		sairButton();
		fundo();
		
		menu.setVisible(true);
	}

}
