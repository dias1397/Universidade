/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lp;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

/**
 *
 * @author efpr
 */
public class ReadFile
{

    private Memoria memoria;

    public ReadFile()
    {
        memoria = new Memoria();
    }
    
    public Memoria getMemoria()
    {
        return memoria;
    }

    public void read(String file) throws FileNotFoundException, IOException
    {
        FileInputStream i_file = new FileInputStream(file);
        InputStreamReader input = new InputStreamReader(i_file);
        BufferedReader buffer = new BufferedReader(input);

        String line = buffer.readLine();
        while (line != null)
        {
            readLine(line);
            line = buffer.readLine();
        }
    }

    private void readLine(String line)
    {
        String inst;
        try
        {
            inst = line.substring(line.indexOf(":") + 1);
        } catch (StringIndexOutOfBoundsException e)
        {
            inst = line;
        }
        StringTokenizer tokens = new StringTokenizer(inst, " |\t");
        if (tokens.hasMoreTokens())
        {
            avaliar(tokens);
        }
    }

    private void avaliar(StringTokenizer tokens)
    {
        String nome = tokens.nextToken();
        switch (nome)
        {
            case "soma":
            case "sub":
            case "mult":
            case "div":
            case "mode":
            case "exp":
                memoria.add(new I_Aritmetica(nome));
                break;
                
            case "salta":
            case "sigual":
            case "smenor":
                memoria.add(new I_Salto(nome, tokens.nextToken()));
                break;
            
            case "empilha":
                memoria.add(new I_Manipulacao_Inteiros(nome, Integer.parseInt(tokens.nextToken())));
                break;
                
            case "empilha_var":
            case "atribui_var":
                memoria.add(new I_Acesso_Variaveis(nome, Integer.parseInt(tokens.nextToken()), Integer.parseInt(tokens.nextToken())));
                break;
            
            case "empilha_arg":
            case "atribui_arg":
                memoria.add(new I_Acesso_Argumentos(nome, Integer.parseInt(tokens.nextToken()), Integer.parseInt(tokens.nextToken())));
                break;
                
            case "coloca_arg":
                memoria.add(new I_Chamada_Funcoes(nome,Integer.parseInt(tokens.nextToken())));
                break;
            case "chama":
                memoria.add(new I_Chamada_Funcoes(nome, Integer.parseInt(tokens.nextToken()), tokens.nextToken()));
                break;
            case "locais":
                memoria.add(new I_Chamada_Funcoes(nome, Integer.parseInt(tokens.nextToken()), Integer.parseInt(tokens.nextToken())));
                break;
            case "regressa":
                memoria.add(new I_Chamada_Funcoes(nome));
                break;
                
            case "escreve_int":
            case "muda_linha":
                memoria.add(new I_Saida(nome));
                break;
            case "escreve_str":
                memoria.add(new I_Saida(nome, tokens.nextToken()));
                break;
            
            default:
                System.out.println("UPS: "+nome);               
        }
    }
}
