import 'package:app_notasorg/controller/cadastro_controller.dart';
import 'package:app_notasorg/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginController {
  final CadastroController cadastroController = GetIt.I<CadastroController>();

  final TextEditingController txtLoginEmail = TextEditingController();
  final TextEditingController txtLoginSenha = TextEditingController();

  bool validarLogin(String email, String senha) {
    if (cadastroController.newUsuario == null) {
      // Nenhum usuário cadastrado ainda
      return false;
    }
    Usuario usuario = cadastroController.newUsuario!;
    return usuario.email.trim().toLowerCase() == email.trim().toLowerCase() && usuario.senha == senha;
  }

  bool validateField(){     //Validar campo vazio
    if (txtLoginEmail.text.isEmpty || txtLoginSenha.text.isEmpty) {
      return false;
    }
    return true;
  }

  void showAlertDialog(BuildContext context) {    //Alerta para caso algum campo vazio
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