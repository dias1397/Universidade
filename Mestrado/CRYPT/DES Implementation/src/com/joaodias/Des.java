package com.joaodias;

import java.util.Arrays;
import java.util.HashMap;

public class Des {
    private static HashMap<Integer, int[]> cn = new HashMap<>(17);
    private static HashMap<Integer, int[]> dn = new HashMap<>(17);

    // Subkeys
    private static HashMap<Integer, int[]> kn = new HashMap<>(16);

    // Left and Right halves
    private static HashMap<Integer, int[]> lh = new HashMap<>(17);
    private static HashMap<Integer, int[]> rh = new HashMap<>(17);

    public static void main(String[] args) {
        int[] key = {
                0, 0, 0, 1, 0, 0, 1, 1,
                0, 0, 1, 1, 0, 1, 0, 0,
                0, 1, 0, 1, 0, 1, 1, 1,
                0, 1, 1, 1, 1, 0, 0, 1,
                1, 0, 0, 1, 1, 0, 1, 1,
                1, 0, 1, 1, 1, 1, 0, 0,
                1, 1, 0, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 0, 0, 0, 1};

        int[] plaintext = {
                0, 0, 0, 0, 0, 0, 0, 1,
                0, 0, 1, 0, 0, 0, 1, 1,
                0, 1, 0, 0, 0, 1, 0, 1,
                0, 1, 1, 0, 0, 1, 1, 1,
                1, 0, 0, 0, 1, 0, 0, 1,
                1, 0, 1, 0, 1, 0, 1, 1,
                1, 1, 0, 0, 1, 1, 0, 1,
                1, 1, 1, 0, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 1,
                0, 0, 1, 0, 0, 0, 1, 1,
                0, 1, 0, 0, 0, 1, 0, 1,
                0, 1, 1, 0, 0, 1, 1, 1,
                1, 0, 0, 0, 1, 0, 0, 1,
                1, 0, 1, 0, 1, 0, 1, 1,
                1, 1, 0, 0, 1, 1, 0, 1,
                1, 1, 1, 0, 1, 1, 1, 1};

        encrypt(plaintext, key);
    }

    private static void encrypt(int[] plaintext, int[] key) {
        key = Utils.validateKey(key);
        plaintext = Utils.validateText(plaintext);
        int[] encrypted = new int[plaintext.length];

        // SUBKEYS GENERATION
        // Generate PC1 permutation of original key
        int[] kPlus = permutate(key, Constants.PC1, 56);
        // Apply left shifts according iterations resulting on Cn and Dn
        applyShifts(kPlus);
        // Generate all 16 subkeys from C16 and D16
        generateSubkeys();

        int[] initialPermutation;
        int[] finalPermutation = new int[64];

        for (int i = 0; i < plaintext.length; i+= 64) {
            // Generate initial permutation (IP)
            initialPermutation = permutate(Arrays.copyOfRange(plaintext, i, i+64), Constants.IP, 64);
            // Generate left halfs and right halfs
            generateLeftAndRight(initialPermutation);

            // Reverse L16 + R16 to R16 + L16
            System.arraycopy(rh.get(16), 0, finalPermutation, 0, rh.get(16).length);
            System.arraycopy(lh.get(16), 0, finalPermutation, rh.get(16).length, lh.get(16).length);
            // Generate final permutation (FP)
            finalPermutation = permutate(finalPermutation, Constants.FP, 64);

            System.arraycopy(finalPermutation, 0, encrypted, i, finalPermutation.length);
        }

        Utils.print(encrypted, 8);
    }

    // Executes a permutation of @plaintext based on a table @table with size @size bits
    private static int[] permutate(int[] input, int[] table, int size) {
        int[] result = new int[size];
        int cont = 0;

        for (int position : table) {
            result[cont++] = input[position-1];
        }

        return result;
    }

    // Apply dependend left shifts to @originalKey according table shifts in class Constants
    private static void applyShifts(int[] originalKey) {
        cn.put(0, Arrays.copyOfRange(originalKey, 0 , originalKey.length/2));
        dn.put(0, Arrays.copyOfRange(originalKey, originalKey.length/2, originalKey.length));

        int iteration = 1;

        for (int leftShif : Constants.shifts) {
            int[] newC = new int[originalKey.length/2];
            System.arraycopy(cn.get(iteration-1), leftShif, newC, 0, cn.get(iteration-1).length - leftShif);
            System.arraycopy(cn.get(iteration-1), 0, newC, cn.get(iteration-1).length - leftShif, leftShif);
            cn.put(iteration, newC);

            int[] newD = new int[originalKey.length/2];
            System.arraycopy(dn.get(iteration-1), leftShif, newD, 0, dn.get(iteration-1).length - leftShif);
            System.arraycopy(dn.get(iteration-1), 0, newD, dn.get(iteration-1).length - leftShif, leftShif);
            dn.put(iteration, newD);

            iteration++;
        }
    }

    // Generate the 16 subkeys that will be used to encrypt data
    private static void generateSubkeys() {
        for (int i = 1; i <= 16; i++) {
            int[] cndn = new int[cn.get(i).length + dn.get(i).length];
            System.arraycopy(cn.get(i), 0, cndn, 0, cn.get(i).length);
            System.arraycopy(dn.get(i), 0, cndn, cn.get(i).length, dn.get(i).length);
            kn.put(i, permutate(cndn, Constants.PC2, 48));
        }
    }

    // Generate all left and right halves from plaintext after the initial permutation
    // It also uses all of the 16 subkeys generated in method generateSubkeys
    private static void generateLeftAndRight(int[] initialPermutation) {
        lh.put(0, Arrays.copyOfRange(initialPermutation, 0 , initialPermutation.length/2));
        rh.put(0, Arrays.copyOfRange(initialPermutation, initialPermutation.length/2, initialPermutation.length));

        for (int i = 1; i <= 16; i++) {
            lh.put(i, rh.get(i-1));
            rh.put(i, Utils.xor(lh.get(i-1), roundFunction(rh.get(i-1), kn.get(i))));
        }
    }

    // Execute round function with the right half and one subkey
    private static int[] roundFunction(int[] rightHalf, int[] key) {
        int[] result = new int[32];

        int[] expanded = permutate(rightHalf, Constants.E, 48);
        int[] boxInput = Utils.xor(expanded, key);

        for (int i = 0; i < 8; i++) {
            int row = Integer.parseInt("" + boxInput[i*6] + boxInput[i*6+5], 2);
            int col = Integer.parseInt("" + boxInput[i*6+1] + boxInput[i*6+2] + boxInput[i*6+3] + boxInput[i*6+4], 2);

            String binaryValue = String.format("%04d", Integer.parseInt(Integer.toBinaryString(Constants.sBoxes.get(i+1)[row][col])));

            result[i*4] = Integer.parseInt("" + binaryValue.charAt(0));
            result[i*4+1] = Integer.parseInt("" + binaryValue.charAt(1));
            result[i*4+2] = Integer.parseInt("" + binaryValue.charAt(2));
            result[i*4+3] = Integer.parseInt("" + binaryValue.charAt(3));
        }

        return permutate(result, Constants.P, 32);
    }
}
