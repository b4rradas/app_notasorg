import 'package:flutter/material.dart';

class Nota {
  String name;
  String priorityTag; // "Alta Prioridade", "Média Prioridade", "Baixa Prioridade"
  Color color;
  String group; // "Trabalho", "Pessoal", "Estudos"
  String description;

  Nota({
    required this.name,
    required this.priorityTag,
    required this.color,
    required this.group,
    required this.description,
  });
}