import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController txtLoginEmail = TextEditingController();
  final TextEditingController txtLoginSenha = TextEditingController();

  bool validateField(){
    if (txtLoginEmail.text.isEmpty || txtLoginSenha.text.isEmpty) {
      return false;
    }
    return true;
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Campos inválidos'),
          content: Text('Por favor, preencha e-mail ou senha.'),
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
}