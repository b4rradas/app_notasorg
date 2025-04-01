import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/model/notas_model.dart';
import 'package:app_notasorg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LixeiraView extends StatelessWidget {
  const LixeiraView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotasController controller = GetIt.I<NotasController>();
    final deletedTasks = controller.deletedtask; 

    void removeTask(Nota task) {
      controller.removeTask(task);
      deletedTasks.remove(task);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarefa removida permanentemente')),
      );
    }

    void emptyTrash() {
      controller.deletedtask.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lixeira esvaziada')),
      );
      Navigator.of(context).pushReplacementNamed('lixeira');
    }

    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Lixeira'),
        backgroundColor: const Color.fromARGB(255, 74, 177, 233),
        actions: [
          IconButton(
            onPressed: () {
              if (deletedTasks.isNotEmpty) {
                emptyTrash();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lixeira já está vazia')),
                );
              }
            },
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Esvaziar Lixeira',
          ),
        ],
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: deletedTasks.isEmpty
                ? const Center(child: Text('Lixeira Vazia'))
                : ListView.builder(
                    itemCount: deletedTasks.length,
                    itemBuilder: (context, index) {
                      final task = deletedTasks[index];
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
                          title: Text(task.name),
                          subtitle: Text(task.description),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'excluir') {
                                removeTask(task);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'excluir',
                                child: Text('Excluir Permanentemente'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
