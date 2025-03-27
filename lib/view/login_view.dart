import 'package:app_notasorg/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = GetIt.I<LoginController>();            //Registrando controller
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color.fromARGB(255, 74, 177, 233),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.txtLoginEmail,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),

              TextFormField(
                controller: controller.txtLoginSenha,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.validateField()) {
                    Navigator.pushNamed(context, 'home');
                  } else {
                    controller.showAlertDialog(context);
                  }
                },
                child: Text('Entrar'),
              ),
              
              TextButton(
                onPressed: () => Navigator.pushNamed(context, 'cadastro'),
                child: Text('Criar Conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
