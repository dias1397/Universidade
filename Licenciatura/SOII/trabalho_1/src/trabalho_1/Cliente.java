 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trabalho_1;

import java.util.ArrayList;
import java.util.Scanner;
import java.util.Vector;

/**
 *
 * @author efpr
 * @author jdias
 * 
 */

public class Cliente
{
 public static void main(String args[])
    {
        String regHost = "localhost";
        String regPort = "9000";  // porto do binder
        
        if (args.length != 2)
        { // requer 3 argumentos
            System.out.println("Usage: java so2.rmi.PalavrasClient registryHost registryPort");
            System.exit(1);
        }
        regHost = args[0];
        regPort = args[1];
        
        try
        {
            // objeto que fica associado ao proxy para objeto remoto
            ObterDados obj = (ObterDados) java.rmi.Naming.lookup("rmi://" + regHost + ":" + regPort + "/Artigos");
            Scanner scan = new Scanner(System.in);
            
            OUTER:
            while (true)
            {
                System.out.println("\n\t    MENU:\n"
                        + "\t********************************************************\n"
                        + "\t* 0 - exit                                             *\n"
                        + "\t* 1 - Obter dados do artigo com o código C             *\n"
                        + "\t* 2 - Obter artigos do autor com código C              *\n"
                        + "\t* 3 - Comprar N exemplares de um artigo com o código C *\n"
                        + "\t* 4 - Determinar o autor com maior volume de vendas    *\n"
                        + "\t********************************************************");
                try
                {
                    System.out.print("\tOpção do Menu: ");
                    int sc = scan.nextInt();
                    switch (sc)
                    {
                        case 0:
                            scan.close();
                            break OUTER;
                        case 1:       // Receber dados de um artigo
                            {
                                System.out.print("\n\tCódigo do artigo: ");
                                int cod_artigo = scan.nextInt();
                                System.out.println("\t" + obj.dadosArtigo(cod_artigo).toString());
                                break;
                            }
                        case 2:
                            {       // Receber os artigos de um autor 
                                System.out.print("\n\tCódigo do autor: ");
                                int cod_autor = scan.nextInt();
                                for(Artigo artigo : obj.artigosAutor(cod_autor))
                                    System.out.println("\t" + artigo.toString()); 
                                break;
                            }
                        case 3:
                            {       // Comprar N exemplares de um artigo
                                System.out.print("\n\tCódigo do artigo: ");
                                int cod_artigo = scan.nextInt();
                                System.out.print("\tQuantidade: ");
                                int quantidade = scan.nextInt();
                                int valido = obj.comprarArtigo(cod_artigo,quantidade);
                                if(valido == -1){
                                    System.out.println("\tCompra inválida por falta de stock\n\tTente Novamente");
                                }
                                break;
                            }
                        case 4:
                            {       //  Calcular o autor com maior numero de vendas
                                for(Autor autor : obj.maisVendas())
                                    System.out.println("\t" + autor.toString());
                                break;
                            }
                        default:
                            break;
                    }
                }catch(java.util.InputMismatchException e)
                {
                    System.out.println("\n!!!!!\tInput Inválido\t!!!!!");
                }
            }
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
