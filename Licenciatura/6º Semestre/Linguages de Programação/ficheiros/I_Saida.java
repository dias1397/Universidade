/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lp;

/**
 *
 * @author efpr
 */
public class I_Saida
{
    private String nome, string;

    public I_Saida(String nome)
    {
        this.nome = nome;
    }

    public I_Saida(String nome, String string)
    {
        this.nome = nome;
        this.string = string;
    }

    public String getNome()
    {
        return nome;
    }

    public void setNome(String nome)
    {
        this.nome = nome;
    }

    public String getString()
    {
        return string;
    }

    public void setString(String string)
    {
        this.string = string;
    }

    @Override
    public String toString() {
        return "I_Saida{" + "nome=" + nome + ", string=" + string + '}';
    }
       
    
}
