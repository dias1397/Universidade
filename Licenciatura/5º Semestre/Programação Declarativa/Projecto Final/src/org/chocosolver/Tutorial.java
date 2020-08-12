package org.chocosolver;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solver;
import org.chocosolver.solver.constraints.Constraint;
import org.chocosolver.solver.constraints.nary.geost.Constants;
import org.chocosolver.solver.constraints.nary.geost.GeostOptions;
import org.chocosolver.solver.constraints.nary.geost.PropGeost;
import org.chocosolver.solver.constraints.nary.geost.externalConstraints.DistGeq;
import org.chocosolver.solver.constraints.nary.geost.externalConstraints.DistLeq;
import org.chocosolver.solver.constraints.nary.geost.externalConstraints.ExternalConstraint;
import org.chocosolver.solver.constraints.nary.geost.externalConstraints.NonOverlapping;
import org.chocosolver.solver.constraints.nary.geost.geometricPrim.GeostObject;
import org.chocosolver.solver.constraints.nary.geost.geometricPrim.ShiftedBox;
import org.chocosolver.solver.constraints.nary.geost.util.InputParser;
import org.chocosolver.solver.constraints.nary.geost.util.RandomProblemGenerator;
import org.chocosolver.solver.search.strategy.Search;
import org.chocosolver.solver.variables.IntVar;
import org.chocosolver.util.ESat;

import java.text.MessageFormat;
import java.util.*;

public class Tutorial {


    public static Constraint geost(int dim, List<GeostObject> objects, List<ShiftedBox> shiftedBoxes, List<ExternalConstraint> eCtrs) {
        return geost(dim, objects, shiftedBoxes, eCtrs, null);
    }

    public static Constraint geost(int dim, List<GeostObject> objects, List<ShiftedBox> shiftedBoxes, List<ExternalConstraint> eCtrs, List<int[]> ctrlVs) {
        return geost(dim, objects, shiftedBoxes, eCtrs, ctrlVs, null);
    }


    public static Constraint geost(int dim, List<GeostObject> objects, List<ShiftedBox> shiftedBoxes, List<ExternalConstraint> eCtrs, List<int[]> ctrlVs, GeostOptions opt) {
        int originOfObjects = objects.size() * dim; //Number of domain variables to represent the origin of all objects
        int otherVariables = objects.size() * 4; //each object has 4 other variables: shapeId, start, duration; end

        /*Collect distance variales due to ditance constraints*/
        List<Integer> distVars = new ArrayList<>(eCtrs.size());
        for (int i = 0; i < eCtrs.size(); i++) {
            ExternalConstraint ectr = eCtrs.get(i);
            if ((ectr instanceof DistLeq) && (((DistLeq) ectr).hasDistanceVar()))
                distVars.add(i);
            if ((ectr instanceof DistGeq) && (((DistGeq) ectr).hasDistanceVar()))
                distVars.add(i);
        }
        //vars will be stored as follows: object 1 coords(so k coordinates), sid, start, duration, end,
        //                                object 2 coords(so k coordinates), sid, start, duration, end and so on ........
        //To retrieve the index of a certain variable, the formula is (nb of the object in question = objId assuming objIds are consecutive and start from 0) * (k + 4) + number of the variable wanted
        //the number of the variable wanted is decided as follows: 0 ... k-1 (the coords), k (the sid), k+1 (start), k+2 (duration), k+3 (end)
        IntVar[] vars = new IntVar[originOfObjects + otherVariables + distVars.size()];
        for (int i = 0; i < objects.size(); i++) {
            for (int j = 0; j < dim; j++) {
                vars[(i * (dim + 4)) + j] = objects.get(i).getCoordinates()[j];
            }
            vars[(i * (dim + 4)) + dim] = objects.get(i).getShapeId();
            vars[(i * (dim + 4)) + dim + 1] = objects.get(i).getStart();
            vars[(i * (dim + 4)) + dim + 2] = objects.get(i).getDuration();
            vars[(i * (dim + 4)) + dim + 3] = objects.get(i).getEnd();
        }
        Model model = vars[0].getModel();
        int ind = 0;
        for (int i : distVars) {
            ExternalConstraint ectr = eCtrs.get(i);
            if (ectr instanceof DistLeq) {
                vars[originOfObjects + otherVariables + ind] = ((DistLeq) ectr).getDistanceVar();
            }
            if (ectr instanceof DistGeq) {
                vars[originOfObjects + otherVariables + ind] = ((DistGeq) ectr).getDistanceVar();
            }

            ind++;
        }

        if (opt == null) {
            opt = new GeostOptions();
        }

        PropGeost propgeost;
        if (ctrlVs == null) {
            propgeost = new PropGeost(vars/*model variables*/, dim, objects, shiftedBoxes, eCtrs, false, opt.included, model.getSolver());
        } else {
            propgeost = new PropGeost(vars, dim, objects, shiftedBoxes, eCtrs, ctrlVs, opt.memoisation, opt.included, opt.increment, model.getSolver());
        }

        Constraint geost = new Constraint("Geost", propgeost);
        return geost;
    }
}
