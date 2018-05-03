/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trabalho_1;

import java.util.ArrayList;

/**
 *
 * @author efpr
 * @author jdias
 * 
 */
public class Artigo implements java.io.Serializable
{
    private int code;
    private String titulo;
    private int stock;
    private int vendidos;
    private ArrayList<Integer> autor;

    public int getCode()
    {
        return code;
    }

    public void setCode(int code)
    {
        this.code = code;
    }

    public String getTitulo()
    {
        return titulo;
    }

    public void setTitulo(String tituço)
    {
        this.titulo = tituço;
    }

    public int getStock()
    {
        return stock;
    }

    public void setStock(int stock)
    {
        this.stock = stock;
    }

    public int getVendidos()
    {
        return vendidos;
    }

    public void setVendidos(int vendidos)
    {
        this.vendidos = vendidos;
    }

    public ArrayList<Integer> getAutor()
    {
        return autor;
    }

    public void setAutor(ArrayList<Integer> autor)
    {
        this.autor = autor;
    }

    @Override
    public String toString()
    {
        return "Artigo{ " + "Código=" + code + ", Titulo=" + titulo + ", Stock=" + stock + ", Vendidos=" + vendidos + ", Autor(es)=" + autor + '}';
    }
    
}
