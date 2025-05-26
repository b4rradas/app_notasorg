import 'package:app_notasorg/controller/cadastro_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      sucesso(context, 'Usuário autenticado com sucesso');
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

  Future<String> usuarioLogado() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'Usuário não logado';
    }

    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection('usuarios')
              .doc(user.uid)
              .get();

      if (documentSnapshot.exists) {
        final userData = documentSnapshot.data();
        if (userData != null && userData.containsKey('nome')) {
          return userData['nome'] as String;
        } else {
          return 'Nome não disponível';
        }
      } else {
        return 'Usuário não encontrado no Firestore';
      }
    } catch (e) {
      return 'Erro ao carregar nome';
    }
  }

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