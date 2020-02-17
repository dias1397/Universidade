import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.SQLOutput;
import java.util.ArrayList;
import java.util.Scanner;

public class WienerAttack {

    private final static BigInteger zero = new BigInteger("0");
    private final static BigInteger one = new BigInteger("1");

    private static ArrayList<BigInteger> pk = new ArrayList<>();
    private static ArrayList<BigInteger> pd = new ArrayList<>();

    private static ArrayList calculate_cf(BigInteger e, BigInteger n) {
        System.out.println("Calculating continued fractions expansion...");
        ArrayList<BigInteger> expansion = new ArrayList<>();

        BigInteger q = e.divide(n);
        BigInteger r = e.mod(n);
        expansion.add(q);

        while (!r.equals(zero)) {
            e = n;
            n = r;

            q = e.divide(n);
            r = e.mod(n);
            expansion.add(q);
        }

        System.out.println("Continued fractions: " + expansion + "\n");
        return expansion;
    }

    private static void calculate_conv(ArrayList<BigInteger> cfe) {
        System.out.println("Calculating convergents of cfe...");

        for (int i = 0; i<cfe.size(); i++) {
            if (i == 0) {
                pk.add(cfe.get(i));
                pd.add(one);
            } else if (i == 1) {
                pk.add((cfe.get(i).multiply(cfe.get(i-1))).add(one));
                pd.add(cfe.get(i));
            } else {
                pk.add((cfe.get(i).multiply(pk.get(i-1))).add(pk.get(i-2)));
                pd.add((cfe.get(i).multiply(pd.get(i-1))).add(pd.get(i-2)));
            }
        }

        System.out.println("Possible k values: " + pk);
        System.out.println("Possible d values: " + pd + "\n");
    }

    public static void execute(BigInteger n, BigInteger e) {
        calculate_conv(calculate_cf(e, n));

        int cont=1;
        BigInteger pphy;
        BigInteger[] roots;

        for (int i = 0; i < pk.size(); i++) {
            if (pk.get(i).equals(zero) || pd.get(i).equals(one) || (pd.get(i).mod(new BigInteger("2"))).equals(zero))
                continue;

            if (!(((e.multiply(pd.get(i))).subtract(one)).mod(pk.get(i))).equals(zero))
                continue;


            pphy = ((e.multiply(pd.get(i))).subtract(one)).divide(pk.get(i));
            System.out.println(String.format("Phy(%d) = (%d * %d - 1) / %d == %d\n", n, e, pd.get(i), pk.get(i), pphy));

            roots = Utils.quadratic_solver(new BigDecimal(one), new BigDecimal((n.subtract(pphy)).add(one)), new BigDecimal(n));
            System.out.println("Probable p: " + roots[0]);
            System.out.println("Probable q: " + roots[1]);

            if (!roots[1].equals(new BigInteger("-1"))) {
                System.out.println(String.format("N = P * Q == %d = %d\n", n, roots[0].multiply(roots[1])));
                if ((roots[0].multiply(roots[1])).equals(n)) {
                    System.out.println("Public  Key: " + n + ", " + e);
                    System.out.println("Private Key: " + n + ", " + e.modInverse(pphy));
                    return;
                }
            }

            if (i == pk.size()-1) {
                System.out.println("Not possible to find private key");
            }
        }
    }

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        System.out.println("Please insert N public value: ");
        //BigInteger n = scan.nextBigInteger();
        BigInteger n = Constants.n1;
        System.out.println("Please insert E public value: ");
        //BigInteger e = scan.nextBigInteger();
        BigInteger e = Constants.e1;

        //System.out.println(calculate_cf(e, n));
        calculate_conv(calculate_cf(e, n));

        BigInteger pphy;
        BigInteger[] roots;

        for (int i = 0; i < pk.size(); i++) {
            if (pk.get(i).equals(zero) || pd.get(i).equals(one) | (pd.get(i).mod(new BigInteger("2"))).equals(zero))
                continue;

            if (!(((e.multiply(pd.get(i))).subtract(one)).mod(pk.get(i))).equals(zero))
                continue;

            pphy = ((e.multiply(pd.get(i))).subtract(one)).divide(pk.get(i));

            roots = Utils.quadratic_solver(new BigDecimal(one), new BigDecimal((n.subtract(pphy)).add(one)), new BigDecimal(n));

            if (!roots[1].equals(new BigInteger("-1"))) {
                if ((roots[0].multiply(roots[1])).equals(n)) {
                    System.out.println("Phy(n): " + pphy);
                    System.out.println("P: " + roots[0]);
                    System.out.println("Q: " + roots[1]);
                    System.out.println("Public  Key: " + n + ", " + e);
                    System.out.println("Private Key: " + n + ", " + e.modInverse(pphy));
                    return;
                }
            }
        }
    }

    class Tuple {
        private int pk;
        private int pd;

        public Tuple(int pk, int pd) {
            this.pk = pk;
            this.pd = pd;
        }

        public int getPk() {
            return pk;
        }

        public int getPd() {
            return pd;
        }
    }
}
