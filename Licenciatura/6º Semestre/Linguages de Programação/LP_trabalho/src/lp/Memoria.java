/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lp;

import java.util.ArrayList;

/**
 *
 * @author efpr
 */
public class Memoria
{
    private ArrayList<Object> memoria;
    private ArrayList<Object> avaliacao;
    private ArrayList<Object> execucao;
    
    public Memoria()
    {
        memoria = new ArrayList<Object>();
        avaliacao = new ArrayList<Object>();
        execucao = new ArrayList<Object>();
    }
    
    public void add_Inst(Object obj)
    {
        memoria.add(obj);
    }

    
}
