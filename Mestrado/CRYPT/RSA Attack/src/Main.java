import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;
import java.security.SecureRandom;
import java.util.Scanner;

public class Main {
    private final static SecureRandom random = new SecureRandom();

    public static void main(String[] args) {
        int option = -1;

        while (option != 0) {
            System.out.println("\n=============WIENER'S ATTACK=============================");
            System.out.println("Seleccione uma das opções");
            System.out.println("= 1\tn: " + Constants.n1 + "\n\te: " + Constants.e1);
            System.out.println("= 2\tn: " + Constants.n2 + "\n\te: " + Constants.e2);
            System.out.println("= 3\tn: " + Constants.n3 + "\n\te: " + Constants.e3);
            System.out.println("= 4\tInserir manualmente");
            System.out.println("= 5\tInserir aleatoriamente");
            System.out.println("= 0\tSAIR");
            System.out.println("========================================================");
            System.out.print("Opção: ");
            Scanner scan = new Scanner(System.in);
            option = scan.nextInt();
            System.out.println("========================================================");

            BigInteger n = new BigInteger("-1");
            BigInteger e = new BigInteger("-1");
            BigInteger d = new BigInteger("-1");

            switch (option) {
                case 1:
                    n = Constants.n1;
                    e = Constants.e1;
                    break;
                case 2:
                    n = Constants.n2;
                    e = Constants.e2;
                    break;
                case 3:
                    n = Constants.n3;
                    e = Constants.e3;
                    break;
                case 4:
                    System.out.print("Valor de n: ");
                    n = scan.nextBigInteger();
                    System.out.print("Valor de e: ");
                    e = scan.nextBigInteger();
                    break;
                case 5:
                    BigInteger p, q;
                    do {
                        p = BigInteger.probablePrime(64/2, random);
                        q = BigInteger.probablePrime(64/2, random);
                    } while(p.compareTo(q) < 0 || p.compareTo(q.multiply(new BigInteger("2"))) > 0);

                    n = p.multiply(q);
                    BigInteger phi = (p.subtract(new BigInteger("1"))).multiply(q.subtract(new BigInteger("1")));

                    MathContext mc = new MathContext(1000);
                    BigDecimal test = new BigDecimal(n);

                    d = ((test.sqrt(mc).sqrt(mc)).divide(new BigDecimal("3"), 2, RoundingMode.HALF_UP)).toBigInteger();

                    do {
                        d = d.subtract(new BigInteger("1"));
                        try {
                            e = d.modInverse(phi);
                        } catch (Exception exc) {
                            continue;
                        }
                    } while ((e.multiply(d)).mod(phi).compareTo(new BigInteger("1")) != 0
                            && d.compareTo(new BigInteger("-1")) != 0);

                    if (d.compareTo(new BigInteger("-1")) == 0) {
                        System.out.println("Falha ao gerar chaves aleatoriamente");
                        continue;
                    }
                    System.out.println("Gerado aleatoriamente\nn = " + n + "\ne = " + e + "\n");
                    break;
            }

            WienerAttack.execute(n, e);

            System.out.println("\n========================================================");
            System.out.println("Seleccione uma das opções");
            System.out.println("= 1\tTestar chave RSA");
            System.out.println("= 0\tSAIR");
            System.out.println("========================================================");
            System.out.print("Opção: ");
            option = scan.nextInt();
            System.out.println("========================================================");

            if (option == 1) {
                System.out.println("A testar encriptação RSA...");
                BigInteger message = new BigInteger(n.bitCount()-1, random);
                System.out.println("Mensagem: " + message);
                System.out.println("Encriptada: " + message.modPow(e, n));
                System.out.println("Desencriptado: " + message.modPow(e, n).modPow(d, n));

                if (message.compareTo(message.modPow(e, n).modPow(d, n)) == 0) {
                    System.out.println("=====================SUCESSO============================");
                } else {
                    System.out.println("===================SEM SUCESSO==========================");
                }

                System.out.println("\n========================================================");
                System.out.println("Testar novamente?");
                System.out.println("= 1\tSim");
                System.out.println("= 0\tNao");
                System.out.println("========================================================");
                System.out.print("Opção: ");
                option = scan.nextInt();
                System.out.println("========================================================");
            }
        }
    }
}
