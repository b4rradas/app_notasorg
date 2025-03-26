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
      appBar: AppBar(title: Text('Cadastro')),
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
                validator: controller.validateNome,
              ),

              TextFormField(
                controller: controller.txtCadastroEmail,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: controller.validateEmail,
              ),

              TextFormField(
                controller: controller.txtCadastroNumero,
                decoration: InputDecoration(labelText: 'Numero'),
                keyboardType: TextInputType.number,
                validator: controller.validateNumero,
              ),

              TextFormField(
                controller: controller.txtCadastroSenha,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: controller.validateSenha,
              ),

              TextFormField(
                controller: controller.txtCadastroConfSenha,
                decoration: InputDecoration(labelText: 'Confirmar Senha'),
                obscureText: true,
                validator: controller.validateConfirmSenha,
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, 'home'),
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}