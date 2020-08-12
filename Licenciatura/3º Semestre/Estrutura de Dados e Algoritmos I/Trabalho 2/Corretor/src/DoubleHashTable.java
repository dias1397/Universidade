/**
 * Created by João on 18/01/2017.
 */
public class DoubleHashTable<E extends Comparable<E>> extends HashTable<E> {
    public DoubleHashTable(){         //Construtor vazio
        elementos = 0;
        tabela = (E[]) new Comparable[100];
    }

    public DoubleHashTable(int n){    //construtor tabela de dimensao n
        if(n>0){
            elementos = 0;
            tabela = (E[]) new Comparable[n];
        }
    }

    public int hash2(E x){
        return maxPrimo(tabela.length) - (Math.abs(x.hashCode()) % maxPrimo(tabela.length));
    }

    public int maxPrimo(int n){
        n++;
        while(!isPrimo(n)){
            n++;
        }
        return n;
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
            int i=1;
            int pos = indice;
            while(tabela[indice]!=null){
                indice = (pos + i*hash2(x)) % tabela.length;
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
                indice = (pos + i*hash2(x)) % tabela.length;
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
