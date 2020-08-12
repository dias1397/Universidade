package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextField;
import javafx.scene.image.ImageView;
import javafx.scene.text.Text;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.*;
import java.util.Random;

public class PerfilController {

    @FXML TextField nome;
    @FXML Text message;
    @FXML Text nomeCao;

    @FXML TextField numero;
    @FXML TextField especie;
    @FXML TextField raca;
    @FXML TextField genero;
    @FXML TextField cor;

    @FXML TextField pelo;
    @FXML TextField cauda;
    @FXML TextField porte;
    @FXML TextField data;
    @FXML TextField responsavel;

    @FXML TextField consulta;
    @FXML CheckBox adocao;

    @FXML ImageView image;
    @FXML Button acao;
    @FXML Button cancelar;
    @FXML Button remove;

    public String action;
    public String animal;

    Map<String, List<String>> mockData = new HashMap<>();
    final Stage dialog = new Stage();

    public PerfilController() {
        mockData.put("Willy", Arrays.asList("123", "cao", "labrador", "masculino", "castanho", "curto", "comprida", "medio", "13-04-2015", "João Dias", "21-09-2019", "false"));
        mockData.put("Pantufa", Arrays.asList("456", "cao", "beagle", "masculino", "preto", "curto", "curta", "pequeno", "17-07-2017", "João Dias", "", "true"));
        mockData.put("Scooby", Arrays.asList("789", "cao", "golden retrivier", "feminino", "branco", "medio", "comprida", "medio", "23-04-2014", "João Dias", "23-10-2019", "false"));
    }

    public void newAnimal() {
        Random rand = new Random();
        nomeCao.setText("Novo");
        action = "new";
        acao.setText("Guardar");
        cancelar.setVisible(true);
        remove.setVisible(false);
        numero.setText("" + rand.nextInt(999));
    }

    public void viewAnimal(String animal) {
        action = "view";
        this.animal = animal;
        nomeCao.setText(animal);
        acao.setText("Editar");
        cancelar.setVisible(true);
        remove.setVisible(true);
        cancelar.setText("Retroceder");
        setAnimal(animal);
        fieldsEdit(false);
    }

    @FXML
    public void cancel(ActionEvent event) throws IOException {
        FXMLLoader fxmlLoader;
        if (action.equals("new") || action.equals("view")) {
            fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/Animais.fxml"));
            Parent root = (Parent)fxmlLoader.load();

            Scene newScene = new Scene(root);
            Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

            window.setScene(newScene);
            window.show();
        } else {
            action = "view";
            acao.setText("Editar");
            cancelar.setVisible(true);
            cancelar.setText("Retroceder");
            setAnimal(animal);
            fieldsEdit(false);
        }

    }

    @FXML
    public void onAction(ActionEvent event) throws IOException {
        if (action.equals("new") || action.equals("edit")) {
            if (!nome.getText().isEmpty() && !responsavel.getText().isEmpty()) {
                message.setText("GUARDADO");
                acao.setText("Editar");
                cancelar.setVisible(true);
                cancelar.setText("Retroceder");
                fieldsEdit(false);
            }else{
                message.setText("Campos obrigatórios:Nome,Responsável");
            }
        } else if (action.equals("view")) {
            acao.setText("Guardar");
            cancelar.setText("Cancelar");
            remove.setVisible(false);
            action = "edit";
            fieldsEdit(true);
        }
    }

    @FXML
    public void onRemove(ActionEvent event) throws IOException {
        dialog.initModality(Modality.APPLICATION_MODAL);
        dialog.initOwner((Stage)((Node)event.getSource()).getScene().getWindow());

        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/Modal.fxml"));
        Parent root = (Parent)fxmlLoader.load();

        Scene dialogScene = new Scene(root, 300, 200);
        dialog.setScene(dialogScene);
        dialog.show();
    }

    public void closeDialog(){
        dialog.close();
    }

    private void fieldsEdit(Boolean editable){
        nome.setEditable(editable);
        especie.setEditable(editable);
        raca.setEditable(editable);
        genero.setEditable(editable);
        cor.setEditable(editable);
        pelo.setEditable(editable);
        cauda.setEditable(editable);
        porte.setEditable(editable);
        data.setEditable(editable);
        responsavel.setEditable(editable);
        consulta.setEditable(editable);
    }

    private void setAnimal(String animal){
        nome.setText(animal);
        numero.setText(mockData.get(animal).get(0));
        especie.setText(mockData.get(animal).get(1));
        raca.setText(mockData.get(animal).get(2));
        genero.setText(mockData.get(animal).get(3));
        cor.setText(mockData.get(animal).get(4));
        pelo.setText(mockData.get(animal).get(5));
        cauda.setText(mockData.get(animal).get(6));
        porte.setText(mockData.get(animal).get(7));
        data.setText(mockData.get(animal).get(8));
        responsavel.setText(mockData.get(animal).get(9));
        consulta.setText(mockData.get(animal).get(10));
        adocao.setSelected(mockData.get(animal).get(11).equals("true"));
    }
}
