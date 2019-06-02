package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.stage.Stage;

import java.io.IOException;

public class ModalController {


    @FXML CheckBox obito;
    @FXML CheckBox adocao;
    @FXML CheckBox transferencia;

    @FXML Button confirm;

    @FXML
    public void onReason(ActionEvent event) throws IOException {
        if (((CheckBox)event.getSource()).getText().equals("Óbito") && obito.isSelected()){
            adocao.setSelected(false);
            transferencia.setSelected(false);
        }
        if (((CheckBox)event.getSource()).getText().equals("Adoção") && adocao.isSelected()){
            obito.setSelected(false);
            transferencia.setSelected(false);
        }
        if (((CheckBox)event.getSource()).getText().equals("Transferência") && transferencia.isSelected()){
            obito.setSelected(false);
            adocao.setSelected(false);
        }

        confirm.setDisable(!(obito.isSelected() || adocao.isSelected() || transferencia.isSelected()));
    }

    @FXML
    public void onConfirm(ActionEvent event) throws IOException {
        PerfilController obj = new PerfilController();
        obj.closeDialog();
    }
}
