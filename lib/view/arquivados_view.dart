import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ArquivadosView extends StatelessWidget {
  const ArquivadosView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotasController controller = GetIt.I<NotasController>();
    final archivedTask = controller.archivedtask; 

    void movetoTrashfromArchived(task){
      controller.deleteTask(task);
      archivedTask.remove(task);
      Navigator.pushNamedAndRemoveUntil(context, 'lixeira', (route) => false);

    }

    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Arquivados'),
        backgroundColor: const Color.fromARGB(255, 74, 177, 233),
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
            child: archivedTask.isEmpty
                ? const Center(child: Text('Nenhuma nota arquivada'))
                : ListView.builder(
                    itemCount: archivedTask.length,
                    itemBuilder: (context, index) {
                      final task = archivedTask[index];
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
                              if (value == 'lixeira'){
                                movetoTrashfromArchived(task);
                              }
                              else if (value == 'restaurar'){
                                controller.restoreTask(task);
                                Navigator.pop(context);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(value: 'lixeira', child: Text('Excluir')),
                              PopupMenuItem(value: 'restaurar', child: Text('Restaurar')),
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
