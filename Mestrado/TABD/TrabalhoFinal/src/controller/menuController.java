package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.Connection;

public class menuController {

    private Connection connection;

    public void setConnection(Connection con) {
        this.connection = con;
    }

    @FXML
    public void insertBook(ActionEvent event) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/bookInsert.fxml"));

        Parent root = (Parent)fxmlLoader.load();
        BookInsertController controller = fxmlLoader.<BookInsertController>getController();
        controller.setConnection(connection);
        Scene newScene = new Scene(root);

        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
        window.setScene(newScene);
        window.show();
    }

    @FXML
    public void insertTag(ActionEvent event) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/tagInsert.fxml"));

        Parent root = (Parent)fxmlLoader.load();
        tagInsertController controller = fxmlLoader.<tagInsertController>getController();
        controller.setConnection(connection);
        Scene newScene = new Scene(root);

        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
        window.setScene(newScene);
        window.show();
    }

    @FXML
    public void insertFile(ActionEvent event) {
        System.out.println("Nova Funcionalidade");
    }
}
