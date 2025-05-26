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

  bool isObscured = true;
  bool isObscuredConfirm = true;
  var icon = Icon(Icons.visibility);
  var iconConfirm = Icon(Icons.visibility);


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
                obscureText: isObscured,
                decoration: InputDecoration(labelText: 'Senha',
                suffixIcon: IconButton(icon: icon, onPressed: _toggleObscure,)),
              ),

              TextFormField(
                controller: controller.txtCadastroConfSenha,
                obscureText: isObscuredConfirm,
                decoration: InputDecoration(labelText: 'Confirmar Senha',
                suffixIcon: IconButton(icon: iconConfirm, onPressed: _toggleObscureConfirm,)),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()  {
                  if (controller.validateFields()) {
                    if (controller.checkPasswords()) {
                      controller.criarConta(context, 
                        controller.txtCadastroNome.text, 
                        controller.txtCadastroEmail.text, 
                        controller.txtCadastroSenha.text, 
                        controller.txtCadastroNumero.text
                      );
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

  void _toggleObscure() {
    isObscured = !isObscured;

    if (isObscured) {
      icon = Icon(Icons.visibility);
    } else {
      icon = Icon(Icons.visibility_off);
    }

    setState(() {});
  }

  void _toggleObscureConfirm() {
    isObscuredConfirm = !isObscuredConfirm;

    if (isObscuredConfirm) {
      iconConfirm = Icon(Icons.visibility);
    } else {
      iconConfirm = Icon(Icons.visibility_off);
    }

    setState(() {});
  }
}