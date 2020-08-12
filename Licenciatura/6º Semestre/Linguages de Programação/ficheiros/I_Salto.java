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
public class I_Salto
{
    private String nome;
    private String etiqueta;
    
    public I_Salto(String nome, String etiqueta)
    {
        this.nome=nome;
        this.etiqueta=etiqueta;
    }

    public String getNome()
    {
        return nome;
    }

    public void setNome(String nome)
    {
        this.nome = nome;
    }

    public String getEtiqueta()
    {
        return etiqueta;
    }

    public void setEtiqueta(String etiqueta)
    {
        this.etiqueta = etiqueta;
    }

    @Override
    public String toString() {
        return "I_Salto{" + "nome=" + nome + ", etiqueta=" + etiqueta + '}';
    }
    
    
}
