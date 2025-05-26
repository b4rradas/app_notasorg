class Nota {
  String? id;
  final String name;
  final String description;
  final String priorityTag;
  final String group;
  final String status;

  Nota({
    this.id,
    required this.name,
    required this.description,
    required this.priorityTag,
    required this.group,
    this.status = 'active',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'priorityTag': priorityTag,
      'group': group,
      'status': status,
    };
  }
}
