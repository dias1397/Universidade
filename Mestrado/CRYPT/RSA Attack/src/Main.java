import java.math.BigInteger;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        System.out.println("=============WIENER'S ATTACK==========");
        System.out.println("Seleccione uma das opções");
        System.out.println("= 1 - n: " + Constants.n1 + ", e: " + Constants.e1);
        System.out.println("= 2 - n: " + Constants.n2 + ", e: " + Constants.e2);
        System.out.println("= 3 - n: " + Constants.n3 + ", e: " + Constants.e3);
        System.out.println("= 4 - n: " + Constants.n4 + ", e: " + Constants.e4);
        System.out.println("= 5 - n: " + Constants.n5 + ", e: " + Constants.e5);
        System.out.println("= 6 - Escolher dados ");

        System.out.print("Opção: ");

        Scanner scan = new Scanner(System.in);
        int option = scan.nextInt();

        System.out.println();

        switch (option) {
            case 1:
                WienerAttack.execute(Constants.n1, Constants.e1);
                break;
            case 2:
                WienerAttack.execute(Constants.n2, Constants.e2);
                break;
            case 3:
                WienerAttack.execute(Constants.n3, Constants.e3);
                break;
            case 4:
                WienerAttack.execute(Constants.n4, Constants.e4);
                break;
            case 5:
                WienerAttack.execute(Constants.n5, Constants.e5);
                break;
            case 6:
                System.out.print("Valor de n: ");
                BigInteger n = scan.nextBigInteger();
                System.out.print("Valor de e: ");
                BigInteger e = scan.nextBigInteger();
                WienerAttack.execute(n, e);
                break;
        }
    }
}
