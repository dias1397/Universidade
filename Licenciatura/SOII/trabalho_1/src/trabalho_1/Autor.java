/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trabalho_1;

/**
 *
 * @author efpr
 * @author jdias
 * 
 */
public class Autor implements java.io.Serializable
{
    private int code;
    private String nome;
    private String email;

    public int getCode()
    {
        return code;
    }

    public void setCode(int code)
    {
        this.code = code;
    }

    public String getNome()
    {
        return nome;
    }

    public void setNome(String nome)
    {
        this.nome = nome;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    @Override
    public String toString()
    {
        return "Autor{ " + "Código=" + code + ", Nome=" + nome + ", Email=" + email + '}';
    }
    
}
