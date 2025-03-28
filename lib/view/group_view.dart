import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GroupView extends StatelessWidget {
  final String groupName;
  final Color groupColor;

  GroupView({super.key, required this.groupName, required this.groupColor});

  final NotasController controller = GetIt.I<NotasController>();

  Color _getPriorityColor(String priorityTag) {
    switch (priorityTag) {
      case 'Alta Prioridade':
        return Colors.red;
      case 'Média Prioridade':
        return Colors.yellow;
      case 'Baixa Prioridade':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = controller.filterByGroup(groupName);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
          },
        ),
        title: Text(groupName),
        backgroundColor: groupColor,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 229, 226),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getPriorityColor(task.priorityTag),
                    radius: 8,
                  ),
                  title: Text(task.name),
                  subtitle: Text(task.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.removeTask(task);
                      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Organizando Para cada grupo

class PessoalView extends StatelessWidget {
  const PessoalView({super.key});

  @override
  Widget build(BuildContext context) => GroupView(groupName: "Pessoal", groupColor: Colors.purple[400]!);
}

class EstudosView extends StatelessWidget {
  const EstudosView({super.key});

  @override
  Widget build(BuildContext context) => GroupView(groupName: "Estudos", groupColor: Colors.green[400]!);
}

class TrabalhoView extends StatelessWidget {
  const TrabalhoView({super.key});

  @override
  Widget build(BuildContext context) => GroupView(groupName: "Trabalho", groupColor: Colors.grey[300]!);
}