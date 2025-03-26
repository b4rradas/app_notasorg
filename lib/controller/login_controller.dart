import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController txtLoginEmail = TextEditingController();
  final TextEditingController txtLoginSenha = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira um email válido';
    }
    return null;
  }

  String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira uma senha';
    }
    return null;
  }
}
