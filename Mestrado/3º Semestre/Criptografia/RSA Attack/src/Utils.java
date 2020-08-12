import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;

public class Utils {

    public static BigInteger[] quadratic_solver(BigDecimal a, BigDecimal b, BigDecimal c) {
        // result = b*b - 4*a*c
        BigDecimal result = (b.multiply(b)).subtract(new BigDecimal("4").multiply(a).multiply(c));
        MathContext mc = new MathContext(1000);

        if (result.compareTo(new BigDecimal("0")) == 1) {
            // r1 = (-b + sqrt(result)) / (2*a)
            BigDecimal r1 = (b.negate().add(result.sqrt(mc))).divide(a.multiply(new BigDecimal("2")));
            // r1 = (-b - sqrt(result)) / (2*a)
            BigDecimal r2 = (b.negate().subtract(result.sqrt(mc))).divide(a.multiply(new BigDecimal("2")));
            //System.out.println("The roots are " + r1 + " and " + r2);
            return new BigInteger[]{r1.toBigInteger().abs(), r2.toBigInteger().abs()};
        } else if (result.compareTo(new BigDecimal("0")) == 0) {
            BigDecimal r1 = b.negate().divide(a.multiply(new BigDecimal("2")));
            //System.out.println("The root is " + r1);
            return new BigInteger[]{r1.toBigInteger().abs(), new BigInteger("-1")};
        } else {
            //System.out.println("The equation has no real roots.");
            return new BigInteger[]{new BigInteger("-1"), new BigInteger("-1")};
        }
    }
}
