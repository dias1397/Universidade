package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.TextField;
import javafx.scene.text.Text;
import org.controlsfx.control.textfield.TextFields;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;

public class tagInsertController {

    @FXML TextField titulo;
    @FXML TextField isbn;
    @FXML TextField descritor;

    @FXML Text message;

    private Connection connection;

    ArrayList<String> titles = new ArrayList<>();
    ArrayList<String> tags = new ArrayList<>();

    @FXML
    public void setConnection(Connection con) {
        this.connection = con;

        String SQL = "SELECT * FROM getTitles()";
        try (PreparedStatement pstmt = connection.prepareStatement(SQL)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                titles.add(rs.getString(1));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        TextFields.bindAutoCompletion(titulo, titles);

        String SQL2 = "SELECT * FROM identificadores";
        try (PreparedStatement pstmt = connection.prepareStatement(SQL2)) {

            ResultSet rs2 = pstmt.executeQuery();

            while (rs2.next()) {
                tags.add(rs2.getString(1));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        TextFields.bindAutoCompletion(descritor, tags);
    }

    @FXML
    public void changeTitle(ActionEvent event)  {
        String SQL = "SELECT isbn FROM livros where titulo = \'" + titulo.getText() + "\'";
        try (PreparedStatement pstmt = connection.prepareStatement(SQL)) {

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                isbn.setText(rs.getString("isbn"));
            }else{
                isbn.setText("");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @FXML
    public void inserir(ActionEvent event)  {
        if (isbn.getText() != null) {
            CallableStatement callableStatement;
            String callableSQL = "{call addBooktag(?,?)}";

            try{
                callableStatement = connection.prepareCall(callableSQL);

                callableStatement.setBigDecimal(1, new BigDecimal(isbn.getText()));
                callableStatement.setString(2, descritor.getText());

                callableStatement.execute();
                callableStatement.close();

                message.setText("Mensagem: descritor inserido no livro " + titulo.getText());

                isbn.setText("");
                titulo.setText("");
                descritor.setText("");

            }catch (SQLException e){
                System.out.println(e.getMessage());
                message.setText("Mensagem: " + e.getMessage().substring(0, e.getMessage().indexOf('.')));
            }

        } else {
            message.setText("Mensagem: O livro escolhido não existe na base de dados");
        }
    }
}
