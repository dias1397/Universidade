package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.TextField;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.io.IOException;

public class LoginController {

    @FXML TextField username;
    @FXML TextField password;

    @FXML Text message;

    @FXML
    public void onLogin(ActionEvent event) throws IOException {
        message.setText("");

        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/MainMenu.fxml"));
        Parent root = (Parent)fxmlLoader.load();

        Scene newScene = new Scene(root);
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

        if (!username.getText().equals(Constants.username)) {
            message.setText("Username incorreto");
        }
        else if (!password.getText().equals(Constants.password)) {
            message.setText("Password incorreta");
        }
        else {
            window.setScene(newScene);
            window.show();
        }
    }

    @FXML
    public void onRegister(ActionEvent event) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/Register.fxml"));
        Parent root = (Parent)fxmlLoader.load();

        Scene newScene = new Scene(root);
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

        window.setScene(newScene);
        window.show();
    }
}
