/**
 * Created by João on 18/01/2017.
 */
public class QuadraticHashTable<E extends Comparable<E>> extends HashTable<E> {

    public QuadraticHashTable(){         //Construtor vazio
        elementos = 0;
        tabela = (E[]) new Comparable[100];
    }

    public QuadraticHashTable(int n){    //construtor tabela de dimensao n
        if(n>0){
            elementos = 0;
            tabela = (E[]) new Comparable[n];
        }
    }

    public int procPos(E x){
        int indice = Math.abs(x.hashCode()) % tabela.length;

        if(factorCarga()>=1){
            rehash();
            insere(x);
        }
        if(tabela[indice]== null){
            return indice;
        } else {
            int pos = indice;
            int i = 1;
            while(tabela[indice]!=null){
                indice = (pos + (i*i)) % tabela.length;
                i++;
            }
            return indice;
        }
    }

    public int procurar(E x){
        int indice = Math.abs(x.hashCode()) % tabela.length;

        if(ocupados()== 0){
            return -1;
        }
        if(tabela[indice]== null){
            return -1;
        }
        if(tabela[indice].compareTo(x)==0){
            return indice;
        } else {
            int pos = indice;
            int i = 1;
            while(tabela[indice]!=null || tabela[indice].compareTo(x)!=0){
                indice = (pos + (i*i)) % tabela.length;
                i++;
            }
            if (tabela[indice]==null){
                return -1;
            }
            if (tabela[indice].compareTo(x)==0){
                return indice;
            }
        }
        return -1;
    }
}
