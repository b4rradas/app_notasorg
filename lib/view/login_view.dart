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

  bool isObscured = true;
  var icone = Icon(Icons.visibility);

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
                  obscureText: isObscured,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(icon: icone, onPressed: _toggleObscure,)),
                ),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (controller.validateField()) {
                      controller.login(context, controller.txtLoginEmail.text, controller.txtLoginSenha.text);
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

  void _toggleObscure() {
    isObscured = !isObscured;

    if (isObscured) {
      icone = Icon(Icons.visibility);
    } else {
      icone = Icon(Icons.visibility_off);
    }

    setState(() {});
  }
}
