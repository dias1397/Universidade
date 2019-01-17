import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.TreeMap;

public class parser {

    public static ArrayList<String> sentence = new ArrayList<>();
    public static String[][] table;
    public static ArrayList<ArrayList<String>> grammar = new ArrayList<>();
    //public static TreeMap<String, ArrayList<String>> grammar = new TreeMap<>();

    public static void main (String[] args)
    {
        Scanner scan = new Scanner(System.in);

        System.out.println("Introduza uma frase:");
        String input = scan.nextLine();

        System.out.println();

        for (String word : input.split(" "))
        {
            sentence.add(word);
        }

        createTable(sentence.size());

        loadGrammar("grammar");

        parserCKY();

    }

    public static void createTable(int numberOfWords)
    {
        table = new String[numberOfWords][];

        for (int i = 0; i < numberOfWords; i++)
        {
            table[i] = new String[numberOfWords-i];
        }

    }

    public static void loadGrammar(String filename)
    {
        try
        {
            FileReader input = new FileReader("src/" + filename);
            BufferedReader bufRead = new BufferedReader(input);
            String line = null;

            while ( (line = bufRead.readLine()) != null)
            {
                String[] parts = line.split(" -> ");

                String key = parts[0];
                int novo = 1;

                for (ArrayList<String> teste : grammar)
                {
                    if (teste.get(0).equals(key)){
                       teste.add(parts[1]);
                       novo = 0;
                    }
                }

                if (novo == 1)
                {
                    ArrayList<String> temp = new ArrayList<>();
                    temp.add(key);
                    temp.add(parts[1]);
                    grammar.add(temp);
                }

            }
            for(ArrayList<String> temp : grammar)
                System.out.println( temp.toString());
        }
        catch (Exception e)
        {
            System.out.println("Error message: " + e.getMessage());
        }
    }

    public static String checkWord(String word)
    {
        String return_ = "";
        for (ArrayList<String> prod : grammar)
        {
            for (int i = 1; i< prod.size(); i++)
            {
                if (word.equals(prod.get(i)))
                {
                    return_ += prod.get(0) + ",";
                }
            }
        }

        return return_;
    }

    public static void parserCKY()
    {
        System.out.println();
        print();

        /*int cont = 0;
        for (int i = 0; i<sentence.size(); i++)
        {
            if (checkWord(sentence.get(i))!=null)
            {
                table[0][i] = checkWord(sentence.get(i));
            }
        }*/
        String r;
        int count;
        for (int i = 0; i<sentence.size(); i++) {
            r = "";
            for (int j = 0; j < grammar.size(); j++) {
                for (count = 1; count < grammar.get(j).size(); count++) {
                    if (grammar.get(j).get(count).equals(sentence.get(i))) {
                        r += grammar.get(j).get(0);
                    }
                }
            }

            table[0][i] = r;
        }

        System.out.println();
        print();

        for(int i = 1; i < sentence.size(); i++){
            for(int j = i; j < sentence.size(); j++){
                r = "";
                for(int k = j - i; k < j; k++){
                    r += combinat(ans_mat[j - i][k], ans_mat[k + 1][j]);
                }
                table[j - i][j] = r;
            }
        }

        System.out.println();
        print();
    }

    static String combinat(String a, String b){
        String to_ret = "", temp = "";
        for(int i = 0; i < a.length(); i++){
            for(int j = 0; j < b.length(); j++){
                temp = "";
                temp += a.charAt(i) + "" +  b.charAt(j);
                to_ret += check(temp);
            }
        }
        return to_ret;
    }

    public static String check(String a){
        String to_ret = "";
        int count = 0;
        for(int i = 0; i < np; i++);
            for(count = 0; count < grammer[i].length; count++){
                if(grammer[i][count].equals(a)){
                    to_ret += grammer[i][0];
                }
            }
        }
        return to_ret;
    }

    public static void print()
    {
        for (String[] x : table)
        {
            for (String y : x)
            {
                System.out.print(y + " ");
            }
            System.out.println();
        }
    }
}
