import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GroupView extends StatelessWidget {
  final String groupName;
  final Color groupColor;

  GroupView({super.key, required this.groupName, required this.groupColor});

  final NotasController controller = GetIt.I<NotasController>();

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
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text(task.description),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                controller.removeTask(task);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}

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
