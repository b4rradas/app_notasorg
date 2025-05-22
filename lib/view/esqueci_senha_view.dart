import 'package:app_notasorg/controller/cadastro_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EsqueciSenhaView extends StatelessWidget {
  final TextEditingController txtEmail = TextEditingController();
  final CadastroController cadastroController = GetIt.I<CadastroController>();

  EsqueciSenhaView({super.key});

  void _verificarEmail(BuildContext context){
    String emailInformado = txtEmail.text.trim().toLowerCase();

    if (cadastroController.newUsuario == null || cadastroController.newUsuario!.email.trim().toLowerCase() != emailInformado){
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email não encontrado'),
            content: Text('Não existe uma conta cadastrada com esse Email'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), 
                child: Text('Ok')
              )
            ],
          );
        }
      );
    } else {
      String senha = cadastroController.newUsuario!.senha;
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Senha Recuperada'),
            content: Text('Sua senha é: $senha'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), 
                child: Text('Ok'),
              )
            ],
          );
        }
      );
    }
  }

  void esqueceuSenha(context, String email) {
    if (email.isNotEmpty){
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      sucesso(context, 'Email enviado com sucesso');
    } else {
      erro(context, 'Iforme o email para recuperar a senha');
    }

    Navigator.pop(context);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueci a Senha'),
        backgroundColor: Color.fromARGB(255, 74, 177, 233),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: txtEmail,
              decoration: InputDecoration(
                labelText: 'Informe seu Email',
                border: OutlineInputBorder(),
              )
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => esqueceuSenha(context, txtEmail.text), 
              child: Text('Recuperar Senha')
            )
          ],
        ),
      ),
    );
  }
}