import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/model/notas_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_notasorg/widgets/widgets.dart';

class PesquisaView extends StatefulWidget {
  const PesquisaView({super.key});

  @override
  State<PesquisaView> createState() => _PesquisaViewState();
}

class _PesquisaViewState extends State<PesquisaView> {
  final NotasController controller = GetIt.I<NotasController>();
  final TextEditingController _searchController = TextEditingController();

  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Notas'),
        backgroundColor: const Color.fromARGB(255, 74, 177, 233),
      ),
      drawer: const SideBar(),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchTerm = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Buscar...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchTerm = '';
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<List<Nota>>(
                    stream: controller.getNotasDoUsuario(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Erro: ${snapshot.error}'),
                        );
                      }

                      final notas = snapshot.data ?? [];

                      final resultados = notas.where((nota) {
                        final name = nota.name.toLowerCase();
                        final description = nota.description.toLowerCase();
                        return name.contains(_searchTerm) ||
                            description.contains(_searchTerm);
                      }).toList();

                      if (resultados.isEmpty) {
                        return const Center(
                          child: Text(
                            'Nenhuma nota encontrada',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: resultados.length,
                        itemBuilder: (context, index) {
                          final nota = resultados[index];
                          return Card(
                            color: Colors.white70,
                            child: Stack(
                              children: [
                                ListTile(
                                  title: Text(nota.name),
                                  subtitle: Text(nota.description),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      'group_${nota.group.toLowerCase()}',
                                    );
                                  },
                                ),
                                // 🔥 Faixa de prioridade na direita
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 8,
                                    color: controller.getPriorityColor(nota.priorityTag),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
