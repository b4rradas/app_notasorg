import 'package:app_notasorg/controller/cadastro_controller.dart';
import 'package:app_notasorg/model/usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginController {
  final CadastroController cadastroController = GetIt.I<CadastroController>();

  final TextEditingController txtLoginEmail = TextEditingController();
  final TextEditingController txtLoginSenha = TextEditingController();

  void login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      sucesso(context, 'Usuario Autenticado com sucesso');
      Navigator.pushReplacementNamed(context, 'home');
      }).catchError((e) {
    switch (e.code) {
      case 'invalid-email':
        erro(context, 'O formato do email é inválido.');  
        break;
      case 'user-not-found':
        erro(context, 'Usuário não encontrado.'); 
        break;
      case 'wrong-password':
        erro(context, 'Senha incorreta.');        
        break;
      default:
        erro(context, e.code.toString());
    }
  });
}


  bool validarLogin(String email, String senha) {     //Validando se usuario ja esta cadastrado
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

void erro(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red.shade900,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

void sucesso(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green.shade900,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
