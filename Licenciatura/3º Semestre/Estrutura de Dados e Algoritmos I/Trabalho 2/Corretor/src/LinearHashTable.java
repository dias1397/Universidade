/**
 * Created by João on 18/01/2017.
 */
public class LinearHashTable<E extends Comparable<E>> extends HashTable<E> {

    public LinearHashTable(){         //Construtor vazio
        elementos = 0;
        tabela = (E[]) new Comparable[100];
    }

    public LinearHashTable(int n){    //construtor tabela de dimensao n
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
            while(tabela[indice]!=null){
                indice++;
                if (indice>=tabela.length){
                    indice = 0;
                }
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
            while(tabela[indice]!=null && tabela[indice].compareTo(x)!=0){
                indice++;
                indice = indice % tabela.length;
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

    /*public static void main(String[] args){
        LinearHashTable isto = new LinearHashTable();
        isto.procPos("oi");
    }*/
}
