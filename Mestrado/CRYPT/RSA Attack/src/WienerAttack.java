import java.util.ArrayList;

public class WienerAttack {

    private static ArrayList<Integer> pk = new ArrayList<>();
    private static ArrayList<Integer> pd = new ArrayList<>();

    private static ArrayList calculate_cf(int e, int n) {
        ArrayList<Integer> expansion = new ArrayList<>();

        int q = e / n;
        int r = e % n;
        expansion.add(q);

        while (r != 0) {
            e = n;
            n = r;

            q = e / n;
            r = e % n;
            expansion.add(q);
        }

        return expansion;
    }

    private static void calculate_conv(ArrayList<Integer> cfe) {
        for (int i = 0; i<cfe.size(); i++) {
            if (i == 0) {
                pk.add(cfe.get(i));
                pd.add(1);
            } else if (i == 1) {
                pk.add(cfe.get(i) * cfe.get(i-1) + 1);
                pd.add(cfe.get(i));
            } else {
                pk.add(cfe.get(i) * pk.get(i-1) + pk.get(i-2));
                pd.add(cfe.get(i) * pd.get(i-1) + pd.get(i-2));
            }
        }

        System.out.println(pk);
        System.out.println(pd);
        System.out.println();
    }



    public static void main(String[] args) {
        int e = /*42667*/17993;
        int n = /*64741*/90581;
        System.out.println(calculate_cf(e, n));
        calculate_conv(calculate_cf(e, n));

        int pphy;
        int[] roots = new int[2];

        for (int i = 0; i < pk.size(); i++) {
            if (pk.get(i) == 0 || pd.get(i) == 1 | pd.get(i) % 2 == 0)
                continue;

            if ((e * pd.get(i) - 1) % pk.get(i) != 0)
                continue;

            pphy = (e * pd.get(i) - 1) / pk.get(i);

            roots = Utils.quadratic_solver(1, (n - pphy + 1), n);

            if (roots[1] != -1) {
                if (roots[0] * roots[1] == n) {
                    System.out.println("P: " + Math.abs(roots[0]));
                    System.out.println("Q: " + Math.abs(roots[1]));
                    System.out.println("Public  Key: " + n + ", " + e);
                    //System.out.println("Private Key: " + n + ", " + e);
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
