import java.math.BigInteger;
import java.security.SecureRandom;

public class RSA {
    private final static BigInteger one      = new BigInteger("1");
    private final static SecureRandom random = new SecureRandom();

    private BigInteger m;
    private BigInteger phi;
    private BigInteger e;
    private BigInteger d;

    // generate an N-bit (roughly) public and private key
    RSA(int size) {
        BigInteger p = BigInteger.probablePrime(size/2, random);
        BigInteger q = BigInteger.probablePrime(size/2, random);

        m = p.multiply(q);
        phi = (p.subtract(one)).multiply(q.subtract(one));

        e  = new BigInteger("3");
        while(phi.gcd(e).intValue() > 1) {
            e = e.add(new BigInteger("2"));
        }
        d = e.modInverse(phi);
    }

    RSA(BigInteger p, BigInteger q) {
        m = p.multiply(q);
        phi = (p.subtract(one)).multiply(q.subtract(one));

        e  = new BigInteger("42667");
        while(phi.gcd(e).intValue() > 1) {
            e = e.add(new BigInteger("2"));
        }

        d = e.modInverse(phi);
    }

    BigInteger encrypt(BigInteger message) {
        return message.modPow(e, m);
    }
    BigInteger decrypt(BigInteger encrypted) {
        return encrypted.modPow(d, m);
    }

    public String toString() {
        String s = "";
        s += "Public (" + m + ", " + e + ")\n";
        s += "Private(" + m + ", " + d + ")\n";
        return s;
    }

    public static void main(String[] args) {
        int n = /*Integer.parseInt(args[0])*/32;
        RSA key = new RSA(n);
        //RSA key = new RSA(new BigInteger("641"), new BigInteger("101"));
        System.out.println(key);

        // create random message, encrypt and decrypt
        BigInteger message = new BigInteger(key.m.bitCount()-1, random);

        //// create message by converting string to integer
        // String s = "test";
        // byte[] bytes = s.getBytes();
        // BigInteger message = new BigInteger(bytes);

        BigInteger encrypt = key.encrypt(message);
        BigInteger decrypt = key.decrypt(encrypt);
        System.out.println("Message   = " + message);
        System.out.println("Encrypted = " + encrypt);
        System.out.println("Decrypted = " + decrypt);
    }
}
