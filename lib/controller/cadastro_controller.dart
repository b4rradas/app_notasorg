import 'package:app_notasorg/model/usuario_model.dart';
import 'package:flutter/material.dart';

class CadastroController {
  final TextEditingController txtCadastroNome = TextEditingController();
  final TextEditingController txtCadastroEmail = TextEditingController();
  final TextEditingController txtCadastroNumero = TextEditingController();
  final TextEditingController txtCadastroSenha = TextEditingController();
  final TextEditingController txtCadastroConfSenha = TextEditingController();

  Usuario? newUsuario;

  bool validateFields() {   //Validar para campo vazio
    if (txtCadastroEmail.text.isEmpty || txtCadastroNome.text.isEmpty || txtCadastroNumero.text.isEmpty 
    || txtCadastroSenha.text.isEmpty || txtCadastroConfSenha.text.isEmpty){
      return false;
    }
    return true;
  }

  bool checkPasswords() {   //Validar senhas iguais
    if (txtCadastroConfSenha.text != txtCadastroSenha.text){
      return false;
    }
    return true;
  }

  void showAlertDialogCad(BuildContext context) {   //Alerta para cas um campo esteja vazio
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Campos inválidos'),
          content: Text('Por favor, preencha todos os campos'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showAlertDialogPassword(BuildContext context) {    //Alera para caso as senhas não forem a mesma
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Senhas Não Coincidem'),
          content: Text('Por favor, tenha certeza de que as senhas são iguais'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

    void cadastrar(){
    // ignore: unused_local_variable
      newUsuario = Usuario(
        nome: txtCadastroNome.text, 
        senha: txtCadastroSenha.text, 
        email: txtCadastroEmail.text, 
        numero: txtCadastroNumero.text
      );
  }
}
