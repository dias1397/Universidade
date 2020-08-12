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
public class I_Manipulacao_Inteiros
{
    private String nome;
    private int inteiro;

    public I_Manipulacao_Inteiros(String nome, int inteiro)
    {
        this.nome = nome;
        this.inteiro = inteiro;
    }

    public String getNome()
    {
        return nome;
    }

    public void setNome(String nome)
    {
        this.nome = nome;
    }

    public int getInteiro()
    {
        return inteiro;
    }

    public void setInteiro(int inteiro)
    {
        this.inteiro = inteiro;
    }

    @Override
    public String toString() {
        return "I_Manipulacao_Inteiros{" + "nome=" + nome + ", inteiro=" + inteiro + '}';
    }
      
    
}
