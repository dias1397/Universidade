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
public interface ObterDados extends java.rmi.Remote
{
    public Artigo dadosArtigo(int i_code) throws Exception;
    public ArrayList<Artigo> artigosAutor(int i_code) throws Exception;
    public ArrayList<Autor> maisVendas() throws Exception;
    public int comprarArtigo(int i_code, int n) throws Exception;
    }
