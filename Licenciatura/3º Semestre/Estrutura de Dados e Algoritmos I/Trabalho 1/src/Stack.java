/**
 * Created by João on 29/11/2016.
 */
public interface Stack<E> {
    public void push(E o);

    public E top();
    public E pop();
    public int size();
    public boolean empty();

    public String toString();
}
