import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/model/notas_model.dart';

class EditarNotaView extends StatefulWidget {
  final Nota nota;
  const EditarNotaView({super.key, required this.nota});

  @override
  _EditarNotaViewState createState() => _EditarNotaViewState();
}

class _EditarNotaViewState extends State<EditarNotaView> {
  final NotasController controller = GetIt.I<NotasController>();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late String _priorityTag;
  late String _group;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.nota.name);
    _descriptionController = TextEditingController(text: widget.nota.description);
    _priorityTag = widget.nota.priorityTag;
    _group = widget.nota.group;
  }

  void _saveEdits() {
    if (_formKey.currentState!.validate()) {
      final editedNota = Nota(
        name: _nameController.text,
        description: _descriptionController.text,
        priorityTag: _priorityTag,
        group: _group,
      );
      final index = controller.tasks.indexOf(widget.nota);
      if (index != -1) {
        controller.editTask(index, editedNota);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Nota"),
        backgroundColor: Color.fromARGB(255, 74, 177, 233),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nome da Nota"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o nome" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Descrição"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe a descrição" : null,
              ),
              DropdownButtonFormField<String>(
                value: _priorityTag,
                items: ['Alta Prioridade', 'Média Prioridade', 'Baixa Prioridade']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _priorityTag = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _group,
                items: ['Pessoal', 'Estudos', 'Trabalho']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _group = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEdits,
                child: const Text("Salvar Alterações"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
