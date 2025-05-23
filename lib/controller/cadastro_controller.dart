import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroController {
  final TextEditingController txtCadastroNome = TextEditingController();
  final TextEditingController txtCadastroEmail = TextEditingController();
  final TextEditingController txtCadastroNumero = TextEditingController();
  final TextEditingController txtCadastroSenha = TextEditingController();
  final TextEditingController txtCadastroConfSenha = TextEditingController();

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

  void criarConta(context, nome, email, senha, numero){
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      FirebaseFirestore.instance.collection('usuarios').add({
        "uid": res.user!.uid.toString(),
        "nome": nome,
        "email": email,
        "numero": numero,
      });
      sucesso(context, 'Usuario cadastrado com sucesso');
      Navigator.pushNamed(context, 'home');
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'Email ja foi cadastrado'); 
          break;
        case 'invalid-email':
          erro(context, 'Email inválido');
          break;
        default:
          erro(context, e.code.toString());
      }
    });
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
