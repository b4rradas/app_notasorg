class Nota {
  String id;
  String name;
  String priorityTag; // "Alta Prioridade", "Média Prioridade", "Baixa Prioridade"
  String group; // "Trabalho", "Pessoal", "Estudos"
  String description;

  Nota({
    this.id = '',
    required this.name,
    required this.priorityTag,
    required this.group,
    required this.description,
  });
}