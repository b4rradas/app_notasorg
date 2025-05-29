import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/model/notas_model.dart';
import 'package:app_notasorg/view/editar_notas_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GroupView extends StatelessWidget {
  final String groupName;
  final Color groupColor;

  GroupView({super.key, required this.groupName, required this.groupColor});

  final NotasController controller = GetIt.I<NotasController>();

  

  @override
  Widget build(BuildContext context) {
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
          StreamBuilder<List<Nota>>(
            stream: controller.getNotasDoUsuario(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Nenhuma nota encontrada.'));
              }

              final tasks = snapshot.data!
                  .where((nota) => nota.group == groupName)
                  .where((nota) => nota.status == 'active')
                  .toList();

              if (tasks.isEmpty) {
                return const Center(child: Text('Nenhuma nota nesse grupo.'));
              }

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return NotaTile(
                    task: task,
                    priorityColor: controller.getPriorityColor(task.priorityTag),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('criar_nota');
        },
        backgroundColor: const Color.fromARGB(76, 0, 0, 0),
        child: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'nova_nota') {
              Navigator.of(context).pushNamed('criar_nota');
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'nova_nota',
              child: Text('Nova Nota'),
            ),
          ],
          child: const Icon(
            Icons.add,
            size: 50,
            color: Color.fromARGB(255, 41, 41, 41),
          ),
        ),
      ),
    );
  }
}


class NotaTile extends StatefulWidget {
  final Nota task;
  final Color priorityColor;

  const NotaTile({super.key, required this.task, required this.priorityColor});

  

  @override
  _NotaTileState createState() => _NotaTileState();
}

class _NotaTileState extends State<NotaTile> {
  bool isChecked = false;
  final NotasController controller = GetIt.I<NotasController>();

  void _onCheckboxChanged(bool? value) async {
    if (value == true) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Concluir tarefa?"),
          content: const Text("Deseja marcar essa tarefa como concluída?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Confirmar"),
            ),
          ],
        ),
      );
      if (confirm == true) {
        setState(() {
          isChecked = true;
        });
        controller.concludeTask(widget.task);
        Navigator.pushNamedAndRemoveUntil(context, 'concluidos', (route) => false);
      }
    } else {
      setState(() {
        isChecked = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
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
        border: Border(
          right: BorderSide(color: widget.priorityColor, width: 6),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
        leading: Checkbox(
          value: isChecked,
          onChanged: _onCheckboxChanged,
        ),
        title: Text(widget.task.name),
        subtitle: Text(widget.task.description),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'lixeira'){
              controller.deleteTask(widget.task);
              Navigator.pushNamedAndRemoveUntil(context, 'lixeira', (route) => false);
            }
            else if (value == 'arquivado'){
              controller.archiveTask(widget.task);
              Navigator.pushNamed(context, 'arquivados');
            }
            else if (value == 'editar'){
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditarNotaView(nota: widget.task),
                ),
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'editar', child: Text('Editar')),
            const PopupMenuItem(value: 'lixeira', child: Text('Excluir')),
            const PopupMenuItem(value: 'arquivado', child: Text('Arquivar')),
          ],
        ),
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