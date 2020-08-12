package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MainMenuController {

    private final String url = "jdbc:postgresql://localhost/library";

    @FXML TextField username;
    @FXML TextField password;

    @FXML
    public void onLogin(ActionEvent event) throws IOException {
        MainMenuController obj = new MainMenuController();
        Connection con = obj.connect(username.getText(), password.getText());

        if(con!=null){
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/menu.fxml"));
            Parent root = (Parent)fxmlLoader.load();
            menuController controller = fxmlLoader.getController();
            controller.setConnection(con);
            Scene newScene = new Scene(root);

            Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
            window.setScene(newScene);
            window.show();
        }
    }

    @FXML
    public Connection connect(String user, String pass) {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url, user, pass);
            System.out.println("Connected to the PostgreSQL server successfully.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return conn;
    }
}
