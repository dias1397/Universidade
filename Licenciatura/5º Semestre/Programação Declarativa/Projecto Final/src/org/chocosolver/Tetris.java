package org.chocosolver;

import com.beust.jcommander.converters.IntegerConverter;
import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solver;
import org.chocosolver.solver.constraints.Constraint;
import org.chocosolver.solver.constraints.nary.geost.Constants;
import org.chocosolver.solver.constraints.nary.geost.externalConstraints.ExternalConstraint;
import org.chocosolver.solver.constraints.nary.geost.externalConstraints.NonOverlapping;
import org.chocosolver.solver.constraints.nary.geost.geometricPrim.GeostObject;
import org.chocosolver.solver.constraints.nary.geost.geometricPrim.ShiftedBox;
import org.chocosolver.solver.search.strategy.Search;
import org.chocosolver.solver.variables.IntVar;
import org.chocosolver.util.tools.ArrayUtils;

import java.util.ArrayList;
import java.util.List;


public class Tetris {

    List<Shape> SHAPES = new ArrayList<>();

    public static void main(String[] args) {
//        new Tetris(new int[]{3, 2, 4, 1, 1, 2, 3}, 7, 7);
        new Tetris(new int[]{0, 0, 1 , 0}, 4, 4);
    }

    public Tetris(int[] qts, int X, int Y) {
        SHAPES.add(new I1());
        SHAPES.add(new I2());
        SHAPES.add(new D1());
        SHAPES.add(new D2());
        SHAPES.add(new L1());
        SHAPES.add(new L2());
        SHAPES.add(new L3());
        SHAPES.add(new L4());
        SHAPES.add(new T1());
        SHAPES.add(new T2());
        SHAPES.add(new T3());
        SHAPES.add(new T4());

        List<ShiftedBox> shapes = new ArrayList<>();
        int sid = 0;
        for (Shape s : SHAPES) {
            sid++;
            for (int i = 0; i < s.boxes.size(); i++) {
                shapes.add(new ShiftedBox(sid, s.offsets.get(i), s.boxes.get(i)));
            }
        }


        /*System.out.printf("%d\n", SHAPES.size());
        System.out.printf("rect_size = \n[");
        for (Shape s : SHAPES) {
            for (int i = 0; i < s.boxes.size(); i++) {
                System.out.printf("| %d, %d \n", s.boxes.get(i)[0], s.boxes.get(i)[1]);
            }
        }
        System.out.printf("|];\n\n");

        /*
        System.out.printf("rect_offset = \n[");
        for (Shape s : SHAPES) {
            for (int i = 0; i < s.boxes.size(); i++) {
                System.out.printf("| %d, %d \n", s.offsets.get(i)[0], s.offsets.get(i)[1]);
            }
        }
        System.out.printf("|];\n\n");
        */

        List<int[]> shapeIds = new ArrayList<>();
        shapeIds.add(new int[]{1, 2}); // I
        shapeIds.add(new int[]{3, 4}); // D
        shapeIds.add(new int[]{5, 6, 7, 8}); // L
        shapeIds.add(new int[]{9, 10, 11, 12}); // T

        Model model = new Model("modelo");

        int dim = 2;
        List<GeostObject> objects = new ArrayList<>();

        List<IntVar> coordinates = new ArrayList<>();
        List<IntVar> theShapes = new ArrayList<>();
        int k = 1;
        for (int j = 0; j < qts.length; j++) {
            for (int i = 0; i < qts[j]; i++) {
                IntVar shapeId = model.intVar("sid_" + k, shapeIds.get(j));
                theShapes.add(shapeId);
                IntVar[] coords = new IntVar[2];
                coords[0] = model.intVar("X_" + k, 1, X, false);
                coords[1] = model.intVar("Y_" + k, 1, Y, false);
                coordinates.add(coords[0]);
                coordinates.add(coords[1]);
                objects.add(new GeostObject(dim, k++, shapeId, coords, model.intVar(1), model.intVar(1), model.intVar(1)));
            }
        }

        List<ExternalConstraint> ectr2 = new ArrayList<>();

        int[] objOfEctr2 = new int[objects.size()];
        for (int d = 0; d < objects.size(); d++) {
            objOfEctr2[d] = objects.get(d).getObjectId();
        }

        NonOverlapping n2 = new NonOverlapping(Constants.NON_OVERLAPPING, ArrayUtils.array(1,dim), objOfEctr2);
        ectr2.add(n2);


        Constraint geost = Tutorial.geost(dim, objects, shapes, ectr2);
        model.post(geost);

        Solver solver = model.getSolver();
        solver.setSearch(Search.inputOrderLBSearch(coordinates.toArray(new IntVar[coordinates.size()])),
                Search.inputOrderLBSearch(theShapes.toArray(new IntVar[theShapes.size()])));
        solver.findAllSolutions().stream().forEach(
                (solution -> {
                    //System.out.println(solution);
                    String frase = new String(solution.toString());
                    frase = frase.substring(9); //Remove "Solution:"
                    //System.out.println("          "+ frase);


                    if (valido(frase, 4, 0,0,1,0)){
                        System.out.println("CERTA : " + solution);
                    }else{
                        //System.out.println("ERRADA: " + solution);
                    }
                })
        );

    }

    public boolean valido(String str, int tamanho, int i, int d, int l, int t){
        int total = i+d+l+t;
        int[][] board = new int[tamanho][tamanho];

        for (int a=0; a<tamanho; a++){
            for (int b=0; b<tamanho; b++){
                board[a][b] = 0;
            }
        }

        if (tamanho<(total)){
            System.out.println("What??????????");
            return false;
        }
        if ((total)==0){
            return false;
        }

        for (int j=0; j<total; j++){
            String help = new String(str.substring(7,9));
            if (help.equals("10") || help.equals("11") || help.equals("12")){

                int x = str.charAt(15) - '0';
                int y = str.charAt(22) - '0';

                if (help.equals("11")){
                    if (x>tamanho-2){          // Shape 3 eixo X
                        return false;
                    }
                    if (y-1<=0){          // Shape 3 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y-1][x] = 1;
                    board[y-1][x+1] = 1;
                    board[y-2][x] = 1;
                }
                if (help.equals("10") ){
                    if (x>tamanho-1){          // Shape 3 eixo X
                        return false;
                    }
                    if (y>tamanho-2){          // Shape 3 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y][x-1] = 1;
                    board[y+1][x-1] = 1;
                    board[y][x] = 1;
                }
                if (help.equals("12")){
                    if (x-1<=0){          // Shape 3 eixo X
                        return false;
                    }
                    if (y>tamanho-2){          // Shape 3 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y][x-1] = 1;
                    board[y+1][x-1] = 1;
                    board[y][x-2] = 1;
                }

                str = str.substring(24);

            } else {

                int x = str.charAt(14) - '0';
                int y = str.charAt(21) - '0';

                if (str.charAt(7)=='1'){
                    if (x>tamanho-3){          // Shape 1 eixo X
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y-1][x] = 1;
                    board[y-1][x+1] = 1;
                    board[y-1][x+2] = 1;
                }
                if (str.charAt(7)=='2'){
                    if (y>tamanho-3){          // Shape 2 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y][x-1] = 1;
                    board[y+1][x-1] = 1;
                    board[y+2][x-1] = 1;
                }

                if (str.charAt(7)=='3'){
                    if (x>tamanho-1){          // Shape 3 eixo X
                        return false;
                    }
                    if (y>tamanho-1){          // Shape 3 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y-1][x] = 1;
                    board[y][x-1] = 1;
                    board[y][x] = 1;
                }
                if (str.charAt(7)=='4'){
                    return false;
                }

                if (str.charAt(7)=='5'){
                    if (x>tamanho-2){          // Shape 3 eixo X
                        return false;
                    }
                    if (y>tamanho-1 || y-1<=0){          // Shape 3 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y-1][x] = 1;
                    board[y-1][x+1] = 1;
                    board[y-2][x+1] = 1;
                }
                if (str.charAt(7)=='7' ){
                    if (x>tamanho-2){          // Shape 3 eixo X
                        return false;
                    }
                    if (y>tamanho-1){          // Shape 3 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y-1][x] = 1;
                    board[y-1][x+1] = 1;
                    board[y-2][x-1] = 1;
                }
                if (str.charAt(7)=='6'){
                    if (x>tamanho-1){          // Shape 3 eixo X
                        return false;
                    }
                    if (y>tamanho-2){          // Shape 3 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y-1][x] = 1;
                    board[y][x] = 1;
                    board[y+1][x] = 1;
                }
                if (str.charAt(7)=='8'){
                    if (x>tamanho-1){          // Shape 3 eixo X
                        return false;
                    }
                    if (y>tamanho-2){          // Shape 3 eixo Y
                        return false;
                    }
                    board[y-1][x-1] = 1;
                    board[y][x-1] = 1;
                    board[y+1][x-1] = 1;
                    board[y+1][x] = 1;
                }

                if (str.charAt(7)=='9'){
                    if (x>tamanho-2){          // Shape 3 eixo X
                        return false;
                    }
                    if (y>tamanho-1){          // Shape 3 eixo Y
                        return false;
                    }

                    board[y-1][x-1] = 1;
                    board[y-1][x] = 1;
                    board[y-1][x+1] = 1;
                    board[y][x] = 1;
                }

                str = str.substring(23);
            }
        }
        int soma=0;
        for (int a=0 ; a<tamanho; a++){
            for (int b=0; b<tamanho; b++){
                if (board[a][b]==1){
                    soma++;
                }
            }
        }
        if (soma!= total*4){
            return false;
        }
        for (int a=0 ; a<tamanho; a++){
            for (int b=0; b<tamanho; b++){
                System.out.print(board[a][b] + " ");
            }
            System.out.println(" ");
        }

        return true;
    }

    private class Shape{
        List<int[]> boxes;
        List<int[]> offsets;

        public Shape() {
            boxes = new ArrayList<>();
            offsets = new ArrayList<>();
        }
    }

    // Peça em Forma de I
    private class I1 extends Shape {
        public I1() {
            offsets.add(new int[]{0, 0});
            boxes.add(new int[]{4, 1});
        }
    }

    private class I2 extends Shape {
        public I2() {
            offsets.add(new int[]{0, 0});
            boxes.add(new int[]{1, 4});
        }
    }

    // Peça em Forma de D
    private class D1 extends Shape {
        public D1() {
            offsets.add(new int[]{0, 0});
            boxes.add(new int[]{2, 2});
        }
    }

    private class D2 extends Shape {
        public D2() {
            offsets.add(new int[]{0, 0});
            boxes.add(new int[]{2, 2});
        }
    }

    // Peça em Forma de L
    private class L1 extends Shape {
        public L1() {
            offsets.add(new int[]{0, 0});
            boxes.add(new int[]{3, 1});
            offsets.add(new int[]{2, -1});
            boxes.add(new int[]{1, 1});
        }
    }

    private class L2 extends Shape {
        public L2() {
            offsets.add(new int[]{0, 0});
            boxes.add(new int[]{1, 1});
            offsets.add(new int[]{1, 0});
            boxes.add(new int[]{1, 3});
        }
    }

    private class L3 extends Shape {
        public L3() {
            offsets.add(new int[]{0, 0});
            boxes.add(new int[]{3, 1});
            offsets.add(new int[]{0, 1});
            boxes.add(new int[]{1, 1});
        }
    }

    private class L4 extends Shape {
        public L4() {
            offsets.add(new int[]{0, 0});
            boxes.add(new int[]{1, 3});
            offsets.add(new int[]{1, 2});
            boxes.add(new int[]{1, 1});
        }
    }

    // Peça em Forma de T
        private class T1 extends Shape {
            public T1() {
                offsets.add(new int[]{0, 0});
                boxes.add(new int[]{3, 1});
                offsets.add(new int[]{1, 1});
                boxes.add(new int[]{1, 1});
            }
        }

        private class T2 extends Shape {
            public T2() {
                offsets.add(new int[]{0, 0});
                boxes.add(new int[]{1, 3});
                offsets.add(new int[]{1, 1});
                boxes.add(new int[]{1, 1});
            }
        }

        private class T3 extends Shape {
            public T3() {
                offsets.add(new int[]{0, 0});
                boxes.add(new int[]{3, 1});
                offsets.add(new int[]{1, -1});
                boxes.add(new int[]{1, 1});
            }
        }

        private class T4 extends Shape {
            public T4() {
                offsets.add(new int[]{0, 0});
                boxes.add(new int[]{1, 1});
                offsets.add(new int[]{1, -1});
                boxes.add(new int[]{1, 3});
            }
        }
}
