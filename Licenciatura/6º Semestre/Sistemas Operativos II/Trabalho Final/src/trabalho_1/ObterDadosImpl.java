/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trabalho_1;

import java.rmi.server.UnicastRemoteObject;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 *
 * @author efpr
 * @author jdias
 * 
 */
public class ObterDadosImpl extends UnicastRemoteObject implements ObterDados, java.io.Serializable
{
    public ObterDadosImpl() throws java.rmi.RemoteException {
        super();
    }

    private String[] getAccess() throws IOException  
    {
        //Aceder as propriedades para obter user e password
        Properties prop = new Properties();
	InputStream input = null;

        input = new FileInputStream("config.properties");

        // load a properties file
        prop.load(input);

        String[] propriedades = new String[2];
        // get the property value and print it out
        propriedades[0] = prop.getProperty("dbuser");
        propriedades[1] = prop.getProperty("dbpassword");

	input.close();
        
        return propriedades;
    }
    
    public Artigo dadosArtigo(int codigo_artigo) throws Exception
    {
        // obter dados do artigo
        String code = Integer.toString(codigo_artigo);
        Artigo artigo = new Artigo();   // criação objeto artigo
        artigo.setCode(codigo_artigo);
       
        String[] propriedades = getAccess();
        PostgresConnector pc = new PostgresConnector("alunos.di.uevora.pt", "l35477", propriedades[0], propriedades[1]);
        pc.connect();   // conectar à base de dados
        
        ResultSet rs = pc.stmt.executeQuery("SELECT titulo,stock,vendidos FROM t1_artigo WHERE code="+code);
        // query para obter dados do artigo na nossa base de dados
        while(rs.next())
        {
            artigo.setTitulo(rs.getString("titulo"));
            artigo.setStock(rs.getInt("stock"));
            artigo.setVendidos(rs.getInt("vendidos"));
            // atribuiçao de valores ao objeto artigo criado inicialmente
        }
        rs = pc.stmt.executeQuery("SELECT code_autor FROM t1_artigo_autor WHERE code_artigo="+code);
        // execução de nova query para saber quais os autores do artigo em questão
        
        ArrayList<Integer> autor = new ArrayList<Integer>();
        while(rs.next())
        {
            autor.add(rs.getInt("code_autor"));
            // adicionar todos os autores do artigo a um arraylist de autores
        }
        artigo.setAutor(autor);
        
        rs.close();
        pc.disconnect();
        
        return artigo;
    }
    
    public ArrayList<Artigo> artigosAutor(int codigo_autor) throws Exception
    {
        // obter dados de artigos de um certo autor
        String code = Integer.toString(codigo_autor);
        ArrayList<Artigo> artigo = new ArrayList<Artigo>();
        // arraylist para guardar todos os artigos do autor
        
        String[] propriedades = getAccess();
        PostgresConnector pc = new PostgresConnector("alunos.di.uevora.pt", "l35477", propriedades[0], propriedades[1]);
        pc.connect();   // conectar à base de dados
        
        ResultSet rs = pc.stmt.executeQuery("SELECT code_artigo FROM t1_artigo_autor WHERE code_autor="+code);
        // query para obter o codigo de todos os artigos desse autor
        while(rs.next())
        {
            Artigo a = dadosArtigo(rs.getInt("code_artigo"));
            // obter dados de cada artigo
            artigo.add(a);
            // colocar os dados num arraylist de artigos
        }
        
        rs.close();
        pc.disconnect();
        
        return artigo;
    }
    
    public ArrayList<Autor> maisVendas() throws Exception
    {
        // calcular o autor com mais vendas
        ArrayList<Autor> autor = new ArrayList<Autor>();
        // arraylist de autores pois pode haver mais que um autor com mais vendas
       
        String[] propriedades = getAccess();
        PostgresConnector pc = new PostgresConnector("alunos.di.uevora.pt", "l35477", propriedades[0], propriedades[1]);
        pc.connect();   // conectar a base de dados
        
        ResultSet rs = pc.stmt.executeQuery("select t1_autor.code, t1_autor.nome, t1_autor.email FROM " +
"(select max(vendidos) as maxi FROM " +
"(select t1_artigo_autor.code_autor as code, sum(vendidos) as vendidos from " +
"t1_artigo, t1_artigo_autor " +
"where t1_artigo_autor.code_artigo = t1_artigo.code " +
"group by t1_artigo_autor.code_autor) as tab) as max, " +
"(select t1_artigo_autor.code_autor as code, sum(vendidos) as vendidos from " +
"t1_artigo, t1_artigo_autor " +
"where t1_artigo_autor.code_artigo = t1_artigo.code " +
"group by t1_artigo_autor.code_autor) as tab1 " +
"INNER JOIN t1_autor on tab1.code=t1_autor.code " +
"where tab1.vendidos = max.maxi ");
        // query para obter os autores com mais vendas
        
        while(rs.next())
        {
            Autor a = new Autor();
            a.setCode(rs.getInt("code"));
            a.setNome(rs.getString("nome"));
            a.setEmail(rs.getString("email"));
            autor.add(a);
        }
        // adicionar cada autor ao arraylist de autores
        
        pc.disconnect();
        return autor;
    }
    
    public int comprarArtigo(int codigo_artigo, int n) throws Exception
    {
        // executar uma compra de n artigos
        Artigo artigo = dadosArtigo(codigo_artigo);
        // obter dados do artigo a comprar
        
        System.out.println("STOCK: " + artigo.getStock());
        if(artigo.getStock() < n)   // se não houver stock suficiente cancelar a compra
            return -1;
        
        String[] propriedades = getAccess();
        PostgresConnector pc = new PostgresConnector("alunos.di.uevora.pt", "l35477", propriedades[0], propriedades[1]);
        pc.connect();      //conectar a base de dados
        
        artigo.setStock(artigo.getStock()-n);
        artigo.setVendidos(artigo.getVendidos()+n);
        pc.stmt.executeUpdate("UPDATE t1_artigo SET stock="+artigo.getStock()+" , vendidos="+artigo.getVendidos()+ " WHERE code="+artigo.getCode());
        pc.stmt.executeUpdate("INSERT INTO  t1_compras (c_artigo,quantidade) VALUES("+artigo.getCode()+","+n+")");
        // querys para atualizar o artigo (stock e numero de vendas) e a tabela de compras
        
        pc.disconnect();
        
        return 1;
    }
    
    
    
    
}
