import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.SQLOutput;
import java.util.ArrayList;
import java.util.Scanner;

public class WienerAttack {

    private static ArrayList<BigInteger> pk = new ArrayList<>();
    private static ArrayList<BigInteger> pd = new ArrayList<>();

    private static ArrayList calculate_cf(BigInteger e, BigInteger n) {
        System.out.println("--> Calculating continued fractions expansion...");
        ArrayList<BigInteger> expansion = new ArrayList<>();

        BigInteger q = e.divide(n);
        BigInteger r = e.mod(n);
        expansion.add(q);

        while (!r.equals(Constants.zero)) {
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
        System.out.println("--> Calculating convergents of cfe...");
        pk.clear();
        pd.clear();

        for (int i = 0; i<cfe.size(); i++) {
            if (i == 0) {
                pk.add(cfe.get(i));
                pd.add(Constants.one);
            } else if (i == 1) {
                pk.add((cfe.get(i).multiply(cfe.get(i-1))).add(Constants.one));
                pd.add(cfe.get(i));
            } else {
                pk.add((cfe.get(i).multiply(pk.get(i-1))).add(pk.get(i-2)));
                pd.add((cfe.get(i).multiply(pd.get(i-1))).add(pd.get(i-2)));
            }
        }

        System.out.println("Possible k values: " + pk);
        System.out.println("Possible d values: " + pd + "\n");
    }

    public static BigInteger execute(BigInteger n, BigInteger e) {
        calculate_conv(calculate_cf(e, n));

        BigInteger pphy;
        BigInteger[] roots;

        for (int i = 0; i < pk.size(); i++) {
            System.out.println("--> Iteration nº" + (i+1) + " of " + pk.size());
            if (pk.get(i).equals(Constants.zero) || pd.get(i).equals(Constants.one) || (pd.get(i).mod(new BigInteger("2"))).equals(Constants.zero)) {
                if (i == pk.size()-1) {
                    System.out.println("Unable to find private key");
                }
                continue;
            }

            if (!(((e.multiply(pd.get(i))).subtract(Constants.one)).mod(pk.get(i))).equals(Constants.zero)) {
                if (i == pk.size()-1) {
                    System.out.println("Unable to find private key");
                }
                continue;
            }

            pphy = ((e.multiply(pd.get(i))).subtract(Constants.one)).divide(pk.get(i));
            System.out.println(String.format("Phy(%d) = (%d * %d - 1) / %d == %d\n", n, e, pd.get(i), pk.get(i), pphy));

            roots = Utils.quadratic_solver(new BigDecimal(Constants.one), new BigDecimal((n.subtract(pphy)).add(Constants.one)), new BigDecimal(n));
            System.out.println("Probable p: " + roots[0]);
            System.out.println("Probable q: " + roots[1]);

            if (!roots[1].equals(new BigInteger("-1"))) {
                System.out.println(String.format("N = P * Q == %d = %d\n", n, roots[0].multiply(roots[1])));
                if ((roots[0].multiply(roots[1])).equals(n)) {
                    System.out.println("Public  Key: " + n + ", " + e);
                    System.out.println("Private Key: " + n + ", " + e.modInverse(pphy));
                    return e.modInverse(pphy);
                }
            }
        }

        return null;
    }
}
