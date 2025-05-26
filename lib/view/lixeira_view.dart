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

    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Lixeira'),
        backgroundColor: const Color.fromARGB(255, 74, 177, 233),
        actions: [
          IconButton(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Esvaziar lixeira'),
                  content: const Text('Tem certeza que deseja excluir todas as notas da lixeira?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Confirmar'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                controller.emptyTrash();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lixeira esvaziada')),
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
          StreamBuilder<List<Nota>>(
            stream: controller.getNotasDoUsuario(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'Lixeira Vazia',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }

              final deletedTasks = snapshot.data!
                  .where((nota) => nota.status == 'deleted')
                  .toList();

              if (deletedTasks.isEmpty) {
                return const Center(
                  child: Text(
                    'Lixeira Vazia',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
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
                            controller.deletePermanently(task);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Nota excluída permanentemente')),
                            );
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
