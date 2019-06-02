package controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.ListView;
import javafx.scene.input.MouseEvent;
import javafx.stage.Stage;

import java.io.IOException;

public class AnimaisController {

    @FXML ListView lista;

    @FXML
    public void initialize() {
        ObservableList<String> items = FXCollections.observableArrayList (
                "Willy", "Pantufa", "Scooby");
        lista.setItems(items);
    }

    @FXML public void handleMouseClick(MouseEvent arg0) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/Perfil.fxml"));
        Parent root = (Parent)fxmlLoader.load();
        PerfilController controller = fxmlLoader.<PerfilController>getController();
        controller.viewAnimal((String)lista.getSelectionModel().getSelectedItem());
        Scene newScene = new Scene(root);
        Stage window = (Stage)((Node)arg0.getSource()).getScene().getWindow();

        window.setScene(newScene);
        window.show();
    }

    @FXML
    public void newAnimal(ActionEvent event) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/Perfil.fxml"));
        Parent root = (Parent)fxmlLoader.load();
        PerfilController controller = fxmlLoader.<PerfilController>getController();
        controller.newAnimal();
        Scene newScene = new Scene(root);
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

        window.setScene(newScene);
        window.show();
    }

    @FXML
    public void search(ActionEvent event) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/MainMenu.fxml"));
        Parent root = (Parent)fxmlLoader.load();

        Scene newScene = new Scene(root);
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

    }
}
