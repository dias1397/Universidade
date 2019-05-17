package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TextField;
import javafx.scene.control.skin.TextFieldSkin;
import javafx.scene.text.Text;
import org.controlsfx.control.textfield.TextFields;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class BookInsertController {

    private Connection connection;

    @FXML TextField isbn;
    @FXML TextField titulo;
    @FXML TextField edicao;
    @FXML TextField idioma;
    @FXML DatePicker lancamento;
    @FXML DatePicker aquisicao;

    @FXML TextField nome;
    @FXML TextField apelido;
    @FXML TextField sexo;
    @FXML DatePicker nascimento;

    @FXML Text livro;
    @FXML Text autor;

    @FXML
    public void newRecord(ActionEvent event) {
        TextFields.bindAutoCompletion();
        CallableStatement callableStatement;

        livro.setText("Livro: ");
        autor.setText("Autor: ");

        int insertCounter = 0;

        String callableSQLbook = "{call addBook(?,?,?,?,?,?)}";
        String callableSQLauthor = "{call addAuthor(?,?,?,?)}";
        String callableSQLauthorOfBook = "{call addAuthorOfBook(?,?,?)}";

        if (!isbn.getText().isEmpty()) {
            try{
                callableStatement = connection.prepareCall(callableSQLbook);

                callableStatement.setBigDecimal(1, new BigDecimal(isbn.getText()));
                callableStatement.setString(2, titulo.getText());
                callableStatement.setInt(3,Integer.parseInt(edicao.getText()));
                callableStatement.setString(4, idioma.getText());
                callableStatement.setObject(5, lancamento.getValue());
                callableStatement.setObject(6, aquisicao.getValue());

                callableStatement.execute();
                callableStatement.close();

                insertCounter++;
                livro.setText("Livro: " + titulo.getText() + " foi adicionado a base de dados");

                isbn.setText("");
                titulo.setText("");
                edicao.setText("");
                idioma.setText("");
                lancamento.setValue(null);
                aquisicao.setValue(null);

            }catch (SQLException e){
                livro.setText("Livro: " + e.getMessage().substring(0, e.getMessage().indexOf('.')));
            }
        }

        if (!nome.getText().isEmpty() && !apelido.getText().isEmpty() && !sexo.getText().isEmpty())
        {
            try{
                callableStatement = connection.prepareCall(callableSQLauthor);

                callableStatement.setString(1, nome.getText());
                callableStatement.setString(2, apelido.getText());
                callableStatement.setString(3, sexo.getText());
                callableStatement.setObject(4, nascimento.getValue());

                callableStatement.execute();
                callableStatement.close();

                insertCounter++;
                autor.setText("Autor: " + nome.getText() + " " + apelido.getText() + " foi adicionado a base de dados");

                nome.setText("");
                apelido.setText("");
                sexo.setText("");
                nascimento.setValue(null);
            }catch (SQLException e){
                autor.setText("Autor: " + e.getMessage().substring(0, e.getMessage().indexOf('.')));
            }
        }


        if (insertCounter == 2) {
            try{
                callableStatement = connection.prepareCall(callableSQLauthorOfBook);

                callableStatement.setBigDecimal(1, new BigDecimal(isbn.getText()));
                callableStatement.setString(2, nome.getText());
                callableStatement.setString(3, apelido.getText());

                callableStatement.execute();
                callableStatement.close();
            }catch (SQLException e){
                System.out.println("EXCEPTION: " + e.getMessage());
            }
        }
    }

    public void setConnection(Connection con) {
        this.connection = con;
    }
}
