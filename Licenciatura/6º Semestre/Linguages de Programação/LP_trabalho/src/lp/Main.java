/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lp;

import java.io.IOException;

/**
 *
 * @author efpr
 */
public class Main
{
    public static void main(String[] args) throws IOException
    {
        ReadFile read = new ReadFile();
        
        if(args.length == 0)
            System.out.println("Miss Files");
        
        for(int i=0; i<args.length; i++)
            read.read(args[i]);
    }
}
