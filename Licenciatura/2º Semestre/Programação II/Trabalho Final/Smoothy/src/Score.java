
import java.awt.*;
import java.io.*;
import javax.swing.*;

public class Score {
	public File file = new File("resource/ScoreRecord.txt");		//Inicializa o ficheiro onde estao guardados os recordes
	public String[] list = new String[6];				//cria os espa�os onde serao guardados os recordes
	
	public JLabel[] nome = new JLabel[6];				//onde serao guardados os nomes
	public JLabel[] scoreRecord = new JLabel[6];		//onde serao guardados os resultados
	public JLabel[] lugar = new JLabel[6];				//onde serao guardadas as posi�oes
	public Font font;
	public JPanel panelRecord = new JPanel(new GridLayout(5,2,1,1));	//organiza a posi�ao e o nome do utilizador correspondente ao score
	public JPanel panelPosicao = new JPanel(new GridLayout(5,1,1,1));	//organiza os resultados
	public JFrame window = new JFrame("Records");		//cria janela para os recordes
	
	public void readFile() throws IOException{		//le o ficheiro e guarda cada linha num espa�o de um array
		BufferedReader reader = new BufferedReader(new FileReader(file));
		int i=0;
		while ((list[i] = reader.readLine()) /*em cada espa�o do array � guardado um score*/!= null) {
			i++;
		}
		reader.close();		//fecha a leitura do ficheiro
	}
	
	public void newFont(int x) throws FontFormatException, IOException{		
		//cria uma nova fonte de letra e recebe como argumento o tamanho da letra
		
		InputStream pixell = new BufferedInputStream(new FileInputStream("resource/pixel.ttf"));
		font = Font.createFont(Font.TRUETYPE_FONT, pixell);
		font = font.deriveFont(Font.PLAIN,x);
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        ge.registerFont(font);
	}
	
	public void janela(){		//defini�oes da janela do score
		window.setSize(400,300);
		window.setLayout(null);
		window.setLocationRelativeTo(null);
		window.setResizable(false);			//impossibilita a maximiza��o da janela
		window.setAlwaysOnTop (true);		//janela fica sempre em primeiro plano
		window.getContentPane().setBackground(Color.white);
		window.getRootPane().setBorder(BorderFactory.createMatteBorder(3, 3, 3, 3, Color.black));
		
		//cria uma imagem (GIF) a ser usada no primeiro classificado
		JPanel coroa = new JPanel();
		ImageIcon icon = new ImageIcon("resource/Coroa.gif");
		coroa.add(new JLabel(icon));
		coroa.setBackground(Color.white);
		coroa.setBounds(330,15,50,50);
		window.add(coroa);
		
		
	}
	
	public void registo() throws FontFormatException, IOException{		//guarda o conteudo do ficheiro nos arrays correspondentes
		newFont(20);
		
		for(int i=0; i<5; i++){
			nome[i] = new JLabel();
			scoreRecord[i] = new JLabel();
			lugar[i] = new JLabel();
			
			lugar[i].setText(i+1+".");		//posi�ao
			lugar[i].setFont(font);
			
			nome[i].setText(list[i].substring(0,list[i].indexOf(' ')));		//nome
			nome[i].setFont(font);
			
			scoreRecord[i].setText(list[i].substring(list[i].indexOf(' '),list[i].length()));		//resultado
			scoreRecord[i].setFont(font);
			
			panelPosicao.add(lugar[i]);
			panelPosicao.setBackground(Color.white);
			
			panelRecord.add(nome[i]);
			panelRecord.setBackground(Color.white);
			panelRecord.add(scoreRecord[i]);
			
		}
		
		panelPosicao.setBounds(20, 30, 30, 200);
		panelRecord.setBounds(50, 30, 400, 200);
		window.add(panelPosicao);
		window.add(panelRecord);
		
	}
	
	public void showScore() throws IOException, FontFormatException{		//mostra a janela dos recordes
		readFile();
		janela();
		registo();
		window.setVisible(true);
	}
	
	public void record(int newScore) throws IOException{
		//escreve no ficheiro possiveis novos recordes e recebe o novo score

		readFile();		//le o ficheiro para guardar dados no array
		int lowScore = Integer.parseInt(list[4].substring(list[4].indexOf(" ")+1 , list[4].length()));
		
		BufferedWriter writer = new BufferedWriter(new FileWriter(file));		
		//apaga tudo o que esta no ficheiro e escreve a tabela atualizada
		
		String name;
		
		if(newScore>lowScore){		//se o novo resultado for maior que o ultimo a lista sera atualizada
			while(true){
				try{
					name = JOptionPane.showInputDialog(null,"Insira o nome:    (max. 10)","Score", JOptionPane.PLAIN_MESSAGE);		//pede o nome
					if(name==null){
						for(int j=0; j<5; j++){
							//escreve no ficheiro a lista atualizada
							writer.write(list[j] +"\n");
						}
						writer.close();		//fecha a edicao
						System.exit(0);
					}
					for(int i=0;i<name.length();i++){
						if(name.charAt(i) == ' ' || name.length()>10){
							throw new Exception();		
							//aciona uma excepcao se o nome contiver um espaco ou tiver mais que dez caracteres
						}
					}
					break;
				}catch(Exception e){
					JOptionPane.showMessageDialog(null, "Nome invalido." );
				}
			}
			list[4] = name + " " + newScore;		//guarda na ultima posicao o nome e o score correspondente
			int i = 3;
			while(i!=-1){		
				//verifica se o score acima e inferior e se isso se verificar ambos sao trocados
				if(Integer.parseInt(list[i+1].substring(list[i+1].indexOf(" ")+1 , list[i+1].length())) > Integer.parseInt(list[i].substring(list[i].indexOf(" ")+1 , list[i].length()))){
					String b = list[i];
					list[i] = list[i+1];
					list[i+1] = b;
					i--;
				}else{
					break;
				}
			}
		}
		for(int j=0; j<5; j++){
			//escreve no ficheiro a lista atualizada
			writer.write(list[j] +"\n");
		}
		writer.close();		//fecha a edicao
	}
}
