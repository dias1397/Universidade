package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.io.IOException;

public class RegisterController {

    @FXML TextField username;
    @FXML TextField email;
    @FXML PasswordField password1;
    @FXML PasswordField password2;

    @FXML Text message;

    @FXML
    public void onRegister(ActionEvent event) throws IOException {
        Boolean validateRegister = true;

        if (username.getText().isEmpty()) {
            message.setText("Preencha o username");
            validateRegister = false;
        }
        if (email.getText().isEmpty()) {
            message.setText("Preencha o email");
            validateRegister = false;
        }
        if (!password1.getText().equals(password2.getText()) || password1.getLength() == 0) {
            message.setText("Passwords não coincidem");
            validateRegister = false;
        }

        if (validateRegister) {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/Animais.fxml"));
            Parent root = (Parent)fxmlLoader.load();

            Scene newScene = new Scene(root);
            Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

            window.setScene(newScene);
            window.show();
        }
    }
    @FXML
    public void onCancel(ActionEvent event) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/Login.fxml"));
        Parent root = (Parent)fxmlLoader.load();

        Scene newScene = new Scene(root);
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

        window.setScene(newScene);
        window.show();
    }
}
