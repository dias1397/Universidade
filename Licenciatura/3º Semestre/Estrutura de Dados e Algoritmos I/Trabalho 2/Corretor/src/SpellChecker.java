import java.io.*;
import java.util.Scanner;
import java.util.concurrent.Exchanger;

/**
 * Created by João on 18/01/2017.
 */
public class SpellChecker {

    public LinearHashTable<String> tab_dic;
    public QuadraticHashTable<String> sugestoes;

    public SpellChecker(String dictFile, String errorFile, String docFile){
        // dictFile  --> dicionario
        // errorfile --> ficheiro com os erros e respetivas correçoes
        // docFile   --> ficheiro a corrigir
        tab_dic = new LinearHashTable<>(691173);
        try {
            BufferedReader br = new BufferedReader(new FileReader("resource/"+dictFile));
            String palavra = br.readLine();
            while(palavra!=null){
                tab_dic.insere(palavra);
                palavra = br.readLine();
            }
        }catch (Exception e){
            System.out.println("ERROR");
        }
        //System.out.println(tab_dic.procurar("f�cil"));
        //System.out.println(tab_dic.procurar("facil"));
        sugestoes = new QuadraticHashTable<>(691173);
        File input = new File("resource/" + docFile);
    }

    public void SpellCheck (String docFile) throws FileNotFoundException{
        // gerar tabela de dispersão com erros e sugestões
        sugestoes = new QuadraticHashTable(691173);
        try {
            Scanner scan = new Scanner("resource/" + docFile);
            String palavra = scan.next();
            while(scan.hasNext()){
                if(tab_dic.procurar(palavra) != -1){
                    palavra = scan.next();
                }else{
                    adjacente(palavra);
                    ad_char(palavra);
                    rem_char(palavra);
                }
            }
        }catch (Exception e){
            System.out.println("ERROR");
        }
        geraFicheiro(sugestoes, "sugestoes.txt");

    }

    public void adjacente(String x){
        char[] c = x.toCharArray();

        for (int i=0; i<x.length()-1; i++){
            char temp = c[i];
            c[i] = c[i+1];
            c[i+1] = temp;

            String sugestao = new String(c);
            if (tab_dic.procurar(sugestao)!=-1){
                sugestoes.insere(sugestao);
            }

            c[i+1]=c[i];
            c[i]=temp;
        }
    }
    public void ad_char(String x){

        for (int i=0; i<x.length(); i++){
            for (char a='a'; a<='z'; a++){
                String sugestao = new String(x.substring(0,i)+a+x.substring(i,x.length()));
                if (tab_dic.procurar(sugestao)!=-1){
                    sugestoes.insere(sugestao);
                }
            }

        }
    }
    public void rem_char(String x){
        for (int i=0; i<x.length(); i++){
            String sugestao = new String(x.substring(0,i)+x.substring(i+1,x.length()));
            if (tab_dic.procurar(sugestao)!=-1){
                sugestoes.insere(sugestao);
            }
        }
    }

    public void geraFicheiro (HashTable<String> sugestoes, String errorFile){

        try{
            BufferedWriter bw = new BufferedWriter(new FileWriter("resource/" + errorFile));
            for (int i=0; i<sugestoes.tabela.length; i++){
                if (sugestoes.tabela[i]!=null){
                    bw.write(sugestoes.tabela[i]);
                    System.out.println(sugestoes.tabela[i]);
                }
            }
        }catch (FileNotFoundException e){
            System.out.println("Erro");
        }catch (IOException e){
            System.out.println("isto");
        }


    }
    public static void main(String[] args) throws FileNotFoundException{
        SpellChecker istog = new SpellChecker("dicionario.txt", "sugestoes.txt", "input.txt");
        istog.SpellCheck("input.txt");
    }
}
