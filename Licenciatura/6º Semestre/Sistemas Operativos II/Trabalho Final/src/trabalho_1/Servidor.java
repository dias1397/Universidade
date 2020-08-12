/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trabalho_1;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Properties;

/**
 *
 * @author efpr
 * @author jdias
 * 
 */
public class Servidor 
{
     public static void main(String args[]) throws IOException
    {
        Properties prop = new Properties();
	OutputStream output = null;
        
        int regPort = 1099; // default RMIRegistry port

        if (args.length != 3)
        { // obrigar 'a presenca de um argumento
            System.out.println("Insuficient arguments");
            System.exit(1);
        }

        output = new FileOutputStream("config.properties");

        // set the properties value
        prop.setProperty("dbuser", args[1]);
        prop.setProperty("dbpassword", args[2]);

        // save properties to project root folder
        prop.store(output, null);
        
        output.close();

        try
        {
            regPort = Integer.parseInt(args[0]);

            ObterDados obj = new ObterDadosImpl();

            java.rmi.registry.Registry registry = java.rmi.registry.LocateRegistry.getRegistry(regPort);

            registry.rebind("Artigos", obj);  // NOME DO SERVICO

            System.out.println("Bound RMI object in registry");
            System.out.println("servidor pronto");
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
