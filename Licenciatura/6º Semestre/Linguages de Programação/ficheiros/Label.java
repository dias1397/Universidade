package lp;

public class Label
{
	private String nome;
	private int tamanho;

	public Label(String nome, int tamanho)
	{
		this.nome = nome;
		this.tamanho = tamanho;
	}

	public String getNome()
    {
        return nome;
    }

    public void setNome(String nome)
    {
        this.nome = nome;
    }

    public String getTamanho()
    {
        return tamanho;
    }

    public void setTamanho(String tamanho)
    {
        this.tamanho = tamanho;
    }

    @Override
    public String toString() {
        return "Label{" + "nome=" + nome + ", tamanho=" + tamanho + '}';
    }
    
    
}