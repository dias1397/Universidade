
import java.util.*;
/**
 * Created by João on 01/12/2016.
 */
public class Expressoes {

    public ArvoreBinaria tree(String x){
        ArrayStack<BynaryNode> treenodes = new ArrayStack<>(50);    //pilha nos das arvores
        ArrayStack<BynaryNode> operators = new ArrayStack<>(50);    //pilha operadores
        BynaryNode<Character>[] no = new BynaryNode[30];            //array de nos
        int count = 0;

        ArrayStack<Character> input = new ArrayStack<>(50);         //pilha com caracteres da expressao infix
        for(int i=0; i<x.length(); i++){
            input.push(x.charAt(i));                                //inicialização da pilha
        }

        while(!input.empty()){
            char temp = input.top();                                //caracter do input variavel temporaria
            input.pop();

            if (isInt(temp)){                                       //se for numero
                no[count] = new BynaryNode<Character>(temp);        //novo no com um numero
                treenodes.push(no[count]);                          //insere-se o no na pilha de numeros
                count++;
            }
            if (temp == ')'){                                       //se for )
                no[count] = new BynaryNode<Character>(temp);        //novo no
                operators.push(no[count]);                          //e coloca-se na pilha de operadores
                count++;
            }
            if ((temp=='+') || (temp=='/') || (temp =='-') || (temp=='*')){     //se for operador
                boolean pushed = false;
                while(!pushed){                                         //repete-se enquanto nao se colocar algo numa pilha
                    if (operators.empty()){                             //se a pilha de operadores tiver vazia
                        no[count] = new BynaryNode<Character>(temp);
                        operators.push(no[count]);                      //coloca-se o novo operador na pilha
                        count++;
                        pushed = true;
                    }else if ((char) operators.top().getElemento() == ')'){     //se o topo da pilha for )
                        no[count] = new BynaryNode<Character>(temp);
                        operators.push(no[count]);                              //coloca-se tambem o novo operador na pilha
                        count++;
                        pushed = true;
                    }else if ((priority(temp)>priority((char) operators.top().getElemento())) || (priority(temp)==priority((char)operators.top().getElemento()))){
                        //se a prioridade do elemento a introduzir for igual ou maior que o topo da pilha
                        no[count] = new BynaryNode<Character>(temp);
                        operators.push(no[count]);                      //coloca-se o novo operador na pilha
                        count++;
                        pushed = true;
                    }else{                                              //se a prioridade do novo operador for menor que o topo da pilha
                        attachOperator(treenodes,operators);            //argumento as duas pilhas
                        //esta funçao cria um no com o operador novo
                        //e define como seus dois "filhos" os dois treenodes(numeros) na pilha de nunmeros
                        //finalmente coloca esse novo no na pilha de treenodes
                    }
                }
            }
            if (temp == '('){           //se o caracter for (
                while ((char) operators.top().getElemento() != ')'){        //repete ate encontrar )
                    attachOperator(treenodes,operators);            //realiza nova formaçao de no da arvore com dois filhos
                }
                operators.pop();
            }
        }
        while (!operators.empty()) {
            attachOperator(treenodes, operators);
        }
        ArvoreBinaria<BynaryNode> arvore = new ArvoreBinaria<>(treenodes.top());
        //arvore.inOrder();
        arvore.draw("Arvore Binaria");
        return arvore;
    }

    public void attachOperator(ArrayStack<BynaryNode> pilha1, ArrayStack<BynaryNode> pilha2 ){
        BynaryNode<Character> operatornode = pilha2.top();
        pilha2.pop();
        if (pilha1.top()==null){
            System.out.println("A expressao inserida é invalida");
            System.exit(1);
        }
        operatornode.setEsquerda(pilha1.top());
        pilha1.pop();
        if (pilha1.top()==null){
            System.out.println("A expressao inserida é invalida");
            System.exit(1);
        }
        operatornode.setDireita(pilha1.top());
        pilha1.pop();
        pilha1.push(operatornode);
    }
    public boolean isInt(char caracter){
        if((int)caracter>=48 && (int)caracter<=57){     //tabela ascii entre 0 e 9 == numero
            return true;
        }
        return false;
    }
    public boolean isOperator(char c) {     //verificar se e operador
        if (c == '+' || c == '-' || c == '*' || c == '/' || c == '^') {
            return true;
        }
        return false;
    }
    public int priority(char op){
        if ((op =='+') || (op =='-'))       //menor prioridade = 1
            return 1;
        if ((op =='/') || (op =='*'))       //maior prioridade = 2
            return 2;
        return 0;
    }

    public StringBuffer postfix(ArvoreBinaria<Character> arvore){
        System.out.println("Expressao lida em postfix:");
        StringBuffer isto = new StringBuffer(arvore.postOrder());       //postfix atraves da leitura postOrdem da arvore
        return isto;                                                    //retorna frase com expressao postfix
    }

    public DoubleList<Integer> lista_operandos(StringBuffer frase){
        DoubleList<Integer> lista_operandos = new DoubleList<>();

        for(int i = 0; i<frase.length(); i++) {
            if (isInt(frase.charAt(i))) {          //se for numero adiciona o elemento as duas listas
                lista_operandos.add(Character.getNumericValue(frase.charAt(i)));
            }
        }

        return lista_operandos;

    }
    public DoubleList<Character> lista_postfix(StringBuffer frase){
        DoubleList<Character> lista_postfix = new DoubleList<>();

        for(int i = 0; i<frase.length(); i++){
            if (frase.charAt(i)==' '){

            }else if (isInt(frase.charAt(i))){          //se for numero adiciona o elemento as duas listas
                lista_postfix.add(frase.charAt(i));
            }else{                                     //se for operador so adiciona a lista postfix
                lista_postfix.add(frase.charAt(i));
            }
        }

        return lista_postfix;

    }

    public int solve(StringBuffer frase){
        ArrayStack<Integer> pilha = new ArrayStack(50);     //pilha onde se irao realizar as contas

        for(int i=0; i<frase.length(); i++){
            if (isInt(frase.charAt(i))){                    //se o caracter for inteiro adiciona se a pilha
                pilha.push(Character.getNumericValue(frase.charAt(i)));
            }
            if (isOperator(frase.charAt(i))){               //se for operador
                int operando1 = pilha.pop();
                int operando2 = pilha.pop();
                pilha.push(calcula(operando1, operando2, frase.charAt(i)));     //realiza-se a operação com os dois numeros presentes nas duas posiçoes
                //antes da pilha
            }
        }
        return pilha.top();                                 //retorna se o topo da pilha que ira ser o resultado final
    }
    public int calcula(int x, int y, char operador){
        if (operador == '-'){
            return y-x;
        }
        if (operador == '+'){
            return x+y;
        }
        if (operador == '*'){
            return x*y;
        }
        if (operador == '/'){
            return y/x;
        }
        return 0;
    }

    public int validade(String frase){
        for(int i=0; i<frase.length(); i++){
            if(!isInt(frase.charAt(i))){                //verificar se nao e inteiro nem operador
                if (!isOperator(frase.charAt(i))){
                    if(frase.charAt(i)!= '('){
                        if (frase.charAt(i) != ')'){
                            if (frase.charAt(i) != ' '){
                                return -1;
                            }
                        }
                    }
                }
            }

        }
        return 1;
    }

    public static void main(String []args){
        Scanner scan = new Scanner(System.in);                          //Scanner
        ArvoreBinaria<Character> infix_tree = new ArvoreBinaria<>();    //Arvore expressao infix
        Expressoes objeto = new Expressoes();                           //objeto da classe
        StringBuffer output = new StringBuffer();                       //Stringbuffer para guardar expressao postfix
        DoubleList<Integer> lista_operandos = new DoubleList<>();
        DoubleList<Character> lista_postfix = new DoubleList<>();

        System.out.println("Digite uma expressao infix valida:");
        String input = scan.nextLine();                                 //input
        if (objeto.validade(input)==-1){
            System.out.println("Esta expressão é invalida, reinicie o programa.");
        }else{
            infix_tree = objeto.tree(input);                                //criaçao da arvore atraves do input
            System.out.println(" ");

            output.append(objeto.postfix(infix_tree));                      //criaçao da expressao postfix
            System.out.println(output);
            System.out.println(" ");

            System.out.println("Double Lists:");
            lista_operandos = objeto.lista_operandos(output);               //criaçao das duas double lists
            lista_postfix = objeto.lista_postfix(output);
            System.out.println(lista_operandos.toString());
            System.out.println(lista_postfix.toString());

            System.out.println(" ");
            System.out.println("Avaliaçao da Expressao:");
            System.out.println(objeto.solve(output));                       //criaçao da avaliaçao da expressao

        }



    }
}