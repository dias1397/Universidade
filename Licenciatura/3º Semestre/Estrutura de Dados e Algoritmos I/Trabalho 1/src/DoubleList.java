/**
 * Created by João on 29/11/2016.
 */
public class DoubleList<E> implements Iterable<E>{

    private int theSize;
    private int modCount = 0;       // contador de mudanças para o iterador
    private Node<E> beginMarker;    // dummy node inicio
    private Node<E> endMarker;      // dummy node fim

    public static class Node<E>{
        public E data;
        public Node<E> prev;
        public Node<E> next;

        public Node(E d, Node<E> p, Node<E> n){
            data = d;
            prev = p;
            next = n;
        }
    }

    public DoubleList(){        //construtor lista dupla
        doClear();
    }

    public void clear(){
        doClear();
    }
    private void doClear(){
        beginMarker = new Node<E>(null, null, null);
        endMarker   = new Node<E>(null, beginMarker, null);     //coloca como prev do ultimo no o primeiro
        beginMarker.next = endMarker;

        theSize = 0;
        modCount++;     //contador de modificaçoes na lista
    }
    public int size(){
        return theSize;
    }
    public boolean isEmpty(){
        return size() == 0;                     // beginMarker.next==endMarker;
    }

    public boolean add(E o){        // mudar para void
        add(size(), o);             // adiciona no fim
        return true;
    }
    public void add(int index, E o){
        addBefore(getNode(index, 0, size()), o);
    }
    private void addBefore(Node<E> p, E o){         // no p é o next
        Node<E> newNode = new Node<>(o, p.prev, p);  //liga o novo no ao no p
        newNode.prev.next = newNode;                //liga o no antes ao novo no
        p.prev = newNode;
        theSize++;
        modCount++;
    }

    private void remove( int index){
        remove( getNode(index));
    }
    private void remove( Node<E> p){
        p.next.prev = p.prev;
        p.prev.next = p.next;
        theSize--;
        modCount++;
    }

    public E get(int index){
        return getNode(index).data;
    }
    public void set(int index, E n_valor){
        Node<E> p = getNode(index);
        p.data = n_valor;
    }
    private Node<E> getNode(int index){
        return getNode(index, 0, size()-1);
    }
    private Node<E> getNode(int index, int lower, int upper){
        Node<E> p;

        if( index < lower || index > upper )
        throw new IndexOutOfBoundsException( );
        
        if( index < size( ) / 2 )
            {
            p = beginMarker.next;
            for( int i = 0; i < index; i++ )
                p = p.next;
            }
        else
        {
            p = endMarker;
            for( int i = size( ); i > index; i-- )
                p = p.prev;
        }
        
        return p;
    }

    public java.util.Iterator<E> iterator(){
        return new DoubleLinkedListIterator();
    }
    public class DoubleLinkedListIterator implements java.util.Iterator<E>{
        private Node<E> current = beginMarker.next;
        private int expectedModCount = modCount;
        private boolean okToRemove = false;
        
        public boolean hasNext( ) {
            return current != endMarker;
        }
        
        public E next( )
        {
            if( modCount != expectedModCount )
                throw new java.util.ConcurrentModificationException( );
            if( !hasNext( ) )
                throw new java.util.NoSuchElementException( );
            
            E nextItem = current.data;
            current = current.next;
            okToRemove = true;
            return nextItem;
        }
        
        public void remove( )
        {
            if( modCount != expectedModCount )
                throw new java.util.ConcurrentModificationException( );
            if( !okToRemove )
                throw new IllegalStateException( );
            
            //DoubleList.false.remove( current.prev );
            expectedModCount++;
            okToRemove = false;
        }
    }

    public String toString(){
        StringBuilder sb = new StringBuilder( "[  " );

        for( E x : this ){
            sb.append( x + "  " );
        }
        sb.append( "]" );
        return new String( sb );
    }



    public static void main(String []args){

    }

}
