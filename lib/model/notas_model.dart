import 'package:flutter/material.dart';

class Task {
  String name;
  String priorityTag; // "Alta Prioridade", "Média Prioridade", "Baixa Prioridade"
  Color color;
  String group; // "Trabalho", "Pessoal", "Estudos"
  DateTime deadline;
  String description;

  Task({
    required this.name,
    required this.priorityTag,
    required this.color,
    required this.group,
    required this.deadline,
    required this.description,
  });
}