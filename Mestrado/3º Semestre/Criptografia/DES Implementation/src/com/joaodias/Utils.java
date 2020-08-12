package com.joaodias;

import java.util.Arrays;

public class Utils {

    public static int[] validateKey(int[] key) {
        int[] result = new int[64];

        if (key.length < 64) {
            System.arraycopy(key, 0, result, 0, key.length);
            Arrays.fill(result, 0);
        } else {
            result = key;
        }

        return result;
    }

    public static int[] validateText(int[] plaintext) {
        int[] result = new int[plaintext.length + (64 - (plaintext.length % 64))];

        if (plaintext.length % 64 != 0) {
            System.arraycopy(plaintext, 0, result, 0, plaintext.length);
            Arrays.fill(result, 0);
        } else {
            result = plaintext;
        }

        return result;
    }

    public static int[] xor(int[] a, int[] b) {
        int[] c = new int[a.length];

        for (int i = 0; i < a.length; i++) {
            c[i] = (a[i] + b[i]) % 2;
        }

        return c;
    }

    public static void print(int[] plaintext, int bitsPerRow) {
        int i = 0;

        for (int bit : plaintext) {
            System.out.print(bit + " ");
            i++;

            if (i == bitsPerRow) {
                System.out.println();
                i = 0;
            }
        }

        System.out.println();
    }

}
