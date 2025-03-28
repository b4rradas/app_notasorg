import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/model/notas_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CriarnotaView extends StatefulWidget {
  const CriarnotaView({super.key});

  @override
  State<CriarnotaView> createState() => _CriarnotaViewState();
}

class _CriarnotaViewState extends State<CriarnotaView> {
  final NotasController controller = GetIt.I<NotasController>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _priorityTag = 'Média Prioridade';
  final Color _taskColor = Colors.pink;
  String _group = 'Pessoal';

  void _createTask() {
    if (_nameController.text.isEmpty) return;
    final newTask = Nota(
      name: _nameController.text,
      description: _descriptionController.text,
      priorityTag: _priorityTag,
      color: _taskColor,
      group: _group,
    );
    controller.addTask(newTask);

    // Redirecionar para a tela do grupo correspondente
    switch (_group) {
      case 'Pessoal':
        Navigator.pushNamedAndRemoveUntil(context, 'group_pessoal', (route) => false);
        break;
      case 'Estudos':
        Navigator.pushNamedAndRemoveUntil(context, 'group_estudos', (route) => false);
        break;
      case 'Trabalho':
        Navigator.pushNamedAndRemoveUntil(context, 'group_trabalho', (route) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome da Tarefa'),
            ),
            DropdownButton<String>(
              value: _priorityTag,
              items: ['Alta Prioridade', 'Média Prioridade', 'Baixa Prioridade']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _priorityTag = value!),
            ),
            DropdownButton<String>(
              value: _group,
              items: ['Pessoal', 'Estudos', 'Trabalho']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _group = value!),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createTask,
              child: const Text('Criar Tarefa'),
            )
          ],
        ),
      ),
    );
  }
}
