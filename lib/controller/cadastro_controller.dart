import 'package:flutter/material.dart';

class CadastroController {
  final TextEditingController txtCadastroNome = TextEditingController();
  final TextEditingController txtCadastroEmail = TextEditingController();
  final TextEditingController txtCadastroNumero = TextEditingController();
  final TextEditingController txtCadastroSenha = TextEditingController();
  final TextEditingController txtCadastroConfSenha = TextEditingController();

  String? validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira seu nome';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira um email válido';
    }
    return null;
  }

  String? validateNumero(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira um numero válido';
    }
    return null;
  }

  String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira uma senha';
    }
    return null;
  }

  String? validateConfirmSenha(String? value) {
    if (value != txtCadastroSenha.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }
}
