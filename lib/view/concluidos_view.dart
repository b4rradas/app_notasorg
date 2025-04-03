import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/widgets/widgets.dart'; // Se o SideBar estiver aqui
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ConcluidosView extends StatelessWidget {
  const ConcluidosView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotasController controller = GetIt.I<NotasController>();
    final concludedTasks = controller.concludedtask; // Lista de tarefas concluídas

    void moveToTrashfromConcluded(task) {
      controller.deleteTask(task); 
      concludedTasks.remove(task); 
      Navigator.pushNamedAndRemoveUntil(context, 'lixeira', (route) => false);
    }

    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Concluídos'),
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
            child: concludedTasks.isEmpty
                ? const Center(child: Text('Sem tarefas concluídas', 
                style: TextStyle(fontWeight: FontWeight.bold)))
                : ListView.builder(
                    itemCount: concludedTasks.length,
                    itemBuilder: (context, index) {
                      final task = concludedTasks[index];
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
                          leading: Icon(Icons.check_circle, color: Colors.green),
                          title: Text(task.name),
                          subtitle: Text(task.description),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'lixeira'){
                                moveToTrashfromConcluded(task);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'lixeira', child: Text('Excluir')),
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
