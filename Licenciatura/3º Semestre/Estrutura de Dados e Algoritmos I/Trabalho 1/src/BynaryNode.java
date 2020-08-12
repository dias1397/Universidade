public class BynaryNode<E>{
    E elemento;
    BynaryNode<E> esquerda;
    BynaryNode<E> direita;

    BynaryNode( E x){
        this( x, null, null);
    }

    BynaryNode( E x, BynaryNode<E> dir, BynaryNode<E> esq){
        elemento = x;
        esquerda = esq;
        direita  = dir;
    }

    public BynaryNode<E> getdireita(){
        return direita;
    }

    public BynaryNode<E> getesquerda(){
        return esquerda;
    }

    public E getElemento(){
        return elemento;
    }

    public void setDireita(BynaryNode<E> no){
        direita = no;
    }

    public void setEsquerda(BynaryNode<E> no){
        esquerda = no;
    }

    public void setElemento(E x){
        elemento = x;
    }

}