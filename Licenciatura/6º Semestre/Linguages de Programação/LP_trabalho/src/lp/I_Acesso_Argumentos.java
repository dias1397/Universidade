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
public class I_Acesso_Argumentos
{
    private String nome;
    private int inteiro1, inteiro2;

    public I_Acesso_Argumentos(String nome, int inteiro1, int inteiro2)
    {
        this.nome = nome;
        this.inteiro1 = inteiro1;
        this.inteiro2 = inteiro2;
    }

    public String getNome()
    {
        return nome;
    }

    public void setNome(String nome)
    {
        this.nome = nome;
    }

    public int getInteiro1()
    {
        return inteiro1;
    }

    public void setInteiro1(int inteiro1)
    {
        this.inteiro1 = inteiro1;
    }

    public int getInteiro2()
    {
        return inteiro2;
    }

    public void setInteiro2(int inteiro2)
    {
        this.inteiro2 = inteiro2;
    }

    @Override
    public String toString() {
        return "I_Acesso_Argumentos{" + "nome=" + nome + ", inteiro1=" + inteiro1 + ", inteiro2=" + inteiro2 + '}';
    }
}
