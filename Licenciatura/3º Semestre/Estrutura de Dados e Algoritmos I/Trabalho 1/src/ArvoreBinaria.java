import jdk.nashorn.internal.ir.BinaryNode;

import java.sql.Array;

/**
 * Created by João on 30/11/2016.
 */
public class ArvoreBinaria<E> {

    private BynaryNode<E> raiz;

    public ArvoreBinaria(){
        raiz = null;
    }       //construtor vazio

    public ArvoreBinaria(BynaryNode<E> no){
        raiz = no;
    }

    public void makeEmpty(){
        raiz = null;
    }       // limpa a arvore
    public boolean isEmpty(){
        return raiz == null;
    }       // verifica se esta vazia



    public void insert(BynaryNode<E> x){
        raiz = insert(x, raiz);
    }

    public BynaryNode<E> insert(BynaryNode<E> x, BynaryNode<E> no){
        if( no == null){
            no = x;
        }else{
            if( no.getesquerda() == null){
                no.esquerda = insert(x, no.esquerda);
            }else{
                no.direita = insert(x, no.direita);
            }
        }
        return no;
    }

    public void inOrder(){          //print da arvore em ordem
        inOrder(raiz);
    }
    public void inOrder(BynaryNode<E> no){
        if(no != null){
            inOrder(no.getesquerda());
            System.out.print(no.getElemento() + " ");
            inOrder(no.getdireita());
        }
    }

    public void preOrder(){         //print da arvore pre ordem
        preOrder(raiz);
    }
    public void preOrder(BynaryNode<E> no){
        if(no != null){
            System.out.print(no.getElemento() + " ");
            preOrder(no.getesquerda());
            preOrder(no.getdireita());
        }
    }


    public StringBuffer postfix = new StringBuffer();       //realizaçao de postfix
    public StringBuffer postOrder(){        //print da arvore em post ordem
        postOrder(raiz);                    //usado para encontrar a expressao postfix
        return postfix;
    }
    public StringBuffer postOrder(BynaryNode<E> no){
        if(no != null){
            postOrder(no.getesquerda());
            postOrder(no.getdireita());
            //System.out.print(no.getElemento() + " ");
            postfix.append(no.getElemento() + " ");
        }
        return postfix;
    }


    //metodos da parte grafica
    private void addTree(BynaryNode<E> x, int coordX, int coordY, GraphDraw f,int j,int nivel,int larg){
        if(x!=null){
            f.addNode(x.getElemento().toString(), coordX,coordY);
            int i=f.nodesSize()-1;
            if(j!=-1){
                f.addEdge(j,i);
            }
            int n=(int)Math.pow(2,nivel);
            int dist=larg/(2*n);
            if(x.esquerda!=null)
                addTree(x.esquerda,coordX-dist,coordY+50,f,i,nivel+1,larg);

            if (x.direita!=null)
                addTree(x.direita,coordX+dist ,coordY+50,f,i,nivel+1,larg);

        }

    }
    public void draw(String s){
        GraphDraw frame = new GraphDraw(s);
        int h=altura();
        int d=30;
        int nos_nivel_h=(int) Math.pow(2,h+1);
        //System.out.println(nos_nivel_h);

        int larguraFrame=d*(nos_nivel_h +1);
        int alturaFrame=70*(h+1);
        //System.out.println(alturaFrame);
        //System.out.println("Largura="+larguraFrame);
        frame.setSize(larguraFrame,alturaFrame);

        frame.setVisible(true);
        if (!isEmpty())
            addTree(raiz, larguraFrame/2,50,frame,-1,1,larguraFrame);
        else
            frame.setSize(50,150);


    }

    public int altura(){
        return altura(raiz);
    }
    private int altura(BynaryNode<E> r){
        if(r == null)
            return 0;
        else
            return 1 + Math.max(altura(r.esquerda), altura(r.direita));
    }


    public static void main(String []args){

    }
}
