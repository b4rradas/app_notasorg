import 'package:app_notasorg/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = GetIt.I<LoginController>();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo_img.jpg'),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.45), 
                          blurRadius: 15, 
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
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
                      if (controller.validarLogin(controller.txtLoginEmail.text, controller.txtLoginSenha.text)){
                        Navigator.pushNamed(context, 'home');
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Email ou senha incorretos')),
                        );
                      }
                    } else {
                      controller.showAlertDialog(context);
                    }
                  },
                  child: Text('Entrar'),
                ),
                
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'esqueci_senha'),
                  child: Text('Esqueci a Senha'),
                ),

                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'cadastro'),
                  child: Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
