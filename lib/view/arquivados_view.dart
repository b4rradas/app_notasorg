import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/model/notas_model.dart';
import 'package:app_notasorg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ArquivadosView extends StatelessWidget {
  const ArquivadosView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotasController controller = GetIt.I<NotasController>();

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
          StreamBuilder<List<Nota>>(
            stream: controller.getNotasDoUsuario(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar notas'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhuma Nota Arquivada',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }

              final archivedTasks = snapshot.data!
                .where((nota) => nota.status == 'archived')
                .toList();

              if (archivedTasks.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhuma nota Arquivada',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
                itemCount: archivedTasks.length,
                itemBuilder: (context, index) {
                  final task = archivedTasks[index];
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
                          onSelected: (value) async {
                            if (value == 'lixeira') {
                              controller.moveToTrashFromArchived(task);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'lixeira', (route) => false);
                            } else if (value == 'restaurar') {
                              controller.restoreTask(task);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Nota restaurada'),
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 'lixeira',
                              child: Text('Excluir'),
                            ),
                            PopupMenuItem(
                              value: 'restaurar',
                              child: Text('Restaurar'),
                            ),
                          ],
                        ),
                      ),
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
        child: const Icon(
          Icons.add,
          size: 50,
          color: Color.fromARGB(255, 41, 41, 41),
        ),
      ),
    );
  }
}
