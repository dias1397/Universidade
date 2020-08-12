
// Conjunto de Instrucoes Maquina Simples

public class CIMS {
  	private ArrayList<Object> memoria;
    private ArrayList<Object> avaliacao;
    private ArrayList<Object> execucao;
    
    public CIMS()
    {
        memoria = new ArrayList<Object>();
        avaliacao = new ArrayList<Object>();
        execucao = new ArrayList<Object>();
    }
    
  	public void add_Inst(Object obj)
    {
        memoria.add(obj);
    }

    public void add_Label(Label label)
    {
    	memoria.add(label);
    }

  	public ArrayList<Object> getMemoria()
  	{
  		return memoria;
  	}

  	public void print()
  	{
  		for(Object temp : memoria)
  		{
  			System.out.printl(temp.toString());
  		}
  	}

  	/** Executa o programa CIMS carregado na maquina. */
  	public void executa()
  	{

  	}
}
