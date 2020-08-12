

/**
 * Created by João on 18/01/2017.
 */
public abstract class HashTable<E extends Comparable<E>> {

    public int elementos;       //numero de elementos
    public E[] tabela;

    public HashTable(){         //Construtor vazio
        elementos = 0;
        tabela = (E[]) new Comparable[100];
    }

    public HashTable(int n){    //construtor tabela de dimensao n
        if(n>0){
            elementos = 0;
            tabela = (E[]) new Comparable[n];
        }
    }

    public int ocupados(){      //retorna o numero de elementos da tabela ocupados
        return elementos;
    }

    public float factorCarga(){ //retorna o factor de carga
        return elementos / tabela.length;
    }

    protected abstract int procPos(E x);    //posiçao em que s será inserido

    public void makeEmpty(){    //esvaziar tabela
        for(int i=0; i<tabela.length; i++){
            tabela[i] = null;
        }
    }

    public abstract int procurar(E x);     //retorna elemento que está na tabela

    public void remove(E x){    //remove o elemento da tabela
        tabela[procurar(x)] = null;
    }

    public void insere(E x){    //insere x na tabela
        tabela[procPos(x)] = x;
        elementos++;
    }

    public void rehash(){       //faz rehashing
        E[] auxiliar1;
        E[] auxiliar2;
        elementos=0;

        int tamanho = 2 * tabela.length;
        while(!isPrimo(tamanho)) {
            tamanho++;
        }

        auxiliar1 = (E[]) new Comparable[tamanho];
        auxiliar2 = (E[]) new Comparable[tabela.length];
        auxiliar2 = tabela;
        tabela = auxiliar1;

        for(int i=0; i<auxiliar2.length; i++){
            E x;
            x = auxiliar2[i];
            if(x!=null){
                this.insere(x);
            }
        }

    }

    public boolean isPrimo(int numero) {
        if (numero == 2){return true;}
        if (numero == 3){return true;}
        if (numero%2 == 0){return false;}
        if (numero%3 == 0){return false;}

        int a = 5;
        int b = 2;

        while (a * a <= numero) {
            if (numero % a == 0) {
                return false;
            }
            a += b;
            b = 6 - b;
        }
        return true;
    }

    public void print(){        //lista os elementos da tabela
        //String frase = "Tabela \n";
        System.out.println("Tabela:");
        for(int i = 0; i<tabela.length; i++) {
            if (tabela[i] == null) {
                //System.out.println(i + " --> null " );
            } else {
                System.out.println( i + " --> " + tabela[i].toString());
            }
        }
    }


}
