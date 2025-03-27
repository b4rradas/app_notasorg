import 'package:app_notasorg/controller/cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final CadastroController controller = GetIt.I<CadastroController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
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
                controller: controller.txtCadastroNome,
                decoration: InputDecoration(labelText: 'Nome'),
              ),

              TextFormField(
                controller: controller.txtCadastroEmail,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),

              TextFormField(
                controller: controller.txtCadastroNumero,
                decoration: InputDecoration(labelText: 'Numero'),
                keyboardType: TextInputType.number,
              ),

              TextFormField(
                controller: controller.txtCadastroSenha,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),

              TextFormField(
                controller: controller.txtCadastroConfSenha,
                decoration: InputDecoration(labelText: 'Confirmar Senha'),
                obscureText: true,
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()  {
                  if (controller.validateFields()) {
                    if (controller.checkPasswords()) {
                      controller.cadastrar();
                      Navigator.pushNamed(context, 'home');
                    }
                    else {
                      controller.showAlertDialogPassword(context);
                    }
                  }
                  else {
                    controller.showAlertDialogCad(context);
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}