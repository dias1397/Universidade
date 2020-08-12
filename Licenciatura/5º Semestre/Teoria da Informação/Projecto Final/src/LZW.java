import java.util.ArrayList;
import java.util.HashMap;

public class LZW
{
	//private HashMap<String,Integer> dictionary = new HashMap<String,Integer>();
	
	// LZW()
	//{
	//	dictionary.put("0",0);
	//	dictionary.put("1",1);
	//}
	/*
	private int search(int value)
	{
		for(int i=0; i<dictionary.size(); i++){
			if(dictionary.containsValue()){
				return i;
			}
		}

		return -1;
	}
	*/
	public ArrayList<Integer> compress(ArrayList<Integer> arg)
	{
		HashMap<String,Integer> dictionary = new HashMap<String,Integer>();
		dictionary.put("0",0);
		dictionary.put("1",1);

		ArrayList<Integer> output = new ArrayList<Integer>();
		String prefix = "",
				sufix = "";
		
		int index = 2;
		for(int i=0; i<arg.size(); i++)
		{
			sufix = arg.get(i).toString();
			String pre_suf = prefix + sufix;
			if(dictionary.get(pre_suf) != null)
				prefix = pre_suf;
			else
			{
				output.add(dictionary.get(prefix));
				
				dictionary.put(pre_suf, index++);
				prefix = sufix;
			}
		}
		
		if(!prefix.equals(""))
			output.add(dictionary.get(prefix));

		//System.out.println(output);
		
		return output;
	}
	
	public ArrayList<Integer> decompress(ArrayList<Integer> arg)
	{
		// Inicializar dicionário com simbolos do alfabeto
		HashMap<Integer, String> dictionary = new HashMap<Integer, String>();
		dictionary.put(0, "0");
		dictionary.put(1, "1");

		// Array com o output da descodificação
		ArrayList<Integer> output = new ArrayList<Integer>();

		int cont=2;
		int prefix = arg.get(0);
		int sufix;

		// Descodificar e output
		if(dictionary.containsKey(prefix))
			output.add(Integer.parseInt(dictionary.get(prefix)));

		// Percorrer argumento codificado
		for(int i=1; i<arg.size(); i++)
		{
			String atual = new String(dictionary.get(prefix));
			String proximo;

			sufix = arg.get(i);

			if(dictionary.containsKey(sufix))
				proximo = dictionary.get(sufix);
			
			else if (sufix == dictionary.size())
				proximo = atual.concat(Character.toString(atual.charAt(0)));
			
			else
				throw new IllegalArgumentException("Má compressão");	
			

			char[] parts = proximo.toCharArray();	// separar string
			// descodifica e output
			for (int j=0; j<parts.length; j++)
				output.add(Integer.parseInt(Character.toString(parts[j])));

			// atualiza dicionario
			dictionary.put(cont, atual.concat(Character.toString(proximo.charAt(0))));

			// atual igual a proximo
			prefix = sufix;
			cont++;
		}
		//System.out.println(output);

		return output;
	}

	
}
