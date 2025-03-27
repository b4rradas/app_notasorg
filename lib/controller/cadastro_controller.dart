import 'package:app_notasorg/model/usuario.dart';
import 'package:flutter/material.dart';

class CadastroController {
  final TextEditingController txtCadastroNome = TextEditingController();
  final TextEditingController txtCadastroEmail = TextEditingController();
  final TextEditingController txtCadastroNumero = TextEditingController();
  final TextEditingController txtCadastroSenha = TextEditingController();
  final TextEditingController txtCadastroConfSenha = TextEditingController();

  bool validateFields() {
    if (txtCadastroEmail.text.isEmpty || txtCadastroNome.text.isEmpty || txtCadastroNumero.text.isEmpty 
    || txtCadastroSenha.text.isEmpty || txtCadastroConfSenha.text.isEmpty){
      return false;
    }
    return true;
  }

  bool checkPasswords() {
    if (txtCadastroConfSenha.text != txtCadastroSenha.text){
      return false;
    }
    return true;
  }

  void showAlertDialogCad(BuildContext context) {
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

  void showAlertDialogPassword(BuildContext context) {
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
    Usuario newUsuario = Usuario(
      nome: txtCadastroNome.text, 
      senha: txtCadastroSenha.text, 
      email: txtCadastroEmail.text, 
      numero: txtCadastroNumero.text);
  }
}
