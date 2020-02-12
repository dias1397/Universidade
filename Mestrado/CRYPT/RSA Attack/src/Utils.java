public class Utils {

    public static int[] quadratic_solver(int a, int b, int c) {
        double result = b * b - 4.0 * a * c;

        if (result > 0.0) {
            double r1 = (-b + Math.pow(result, 0.5)) / (2.0 * a);
            double r2 = (-b - Math.pow(result, 0.5)) / (2.0 * a);
            //System.out.println("The roots are " + r1 + " and " + r2);
            return new int[]{(int)r1, (int)r2};
        } else if (result == 0.0) {
            double r1 = -b / (2.0 * a);
            //System.out.println("The root is " + r1);
            return new int[]{(int)r1, -1};
        } else {
            //System.out.println("The equation has no real roots.");
            return new int[]{-1, -1};
        }
    }
}
