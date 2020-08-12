/**
 * Created by João on 29/11/2016.
 */
public class ArrayStack<E> implements Stack<E> {

    public int top = -1;
    private E[] pilha;

    public ArrayStack(int size) {
        pilha = (E[]) new Object[size];
    }

    public void push(E o) {
        top++;
        pilha[top] = o;
    }

    public E top() {        //throws
        if (empty()) {
            return null;
        }
        return pilha[size()-1];
    }

    public E pop() {        //throws
        E objeto_a_remover = pilha[top];
        pilha[top--] = null;    //reduz o top
        return objeto_a_remover;
    }

    public int size() {
        return (top + 1);
    }

    public boolean empty() {
        return (top == -1);
    }

    public String toString() {
        String frase = "";
        for (int i = top; i > -1; i--) {
            frase += pilha[i] + "\n";
        }
        return frase;
    }

}