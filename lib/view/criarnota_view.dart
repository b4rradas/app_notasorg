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
  late DateTime _deadline;

  void _pickDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _deadline = picked);
    }
  }

  void _createTask() {
    if (_nameController.text.isEmpty) return;
    final newTask = Nota(
      name: _nameController.text,
      description: _descriptionController.text,
      priorityTag: _priorityTag,
      color: _taskColor,
      group: _group,
      deadline: _deadline,
    );
    controller.addTask(newTask);
    Navigator.pop(context);
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
            ElevatedButton(
              onPressed: () => _pickDeadline(context),
              child: Text(_deadline == null
                  ? 'Escolher Prazo'
                  : 'Prazo: ${_deadline!.toLocal()}'.split(' ')[0]),
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
