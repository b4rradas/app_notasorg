import 'package:flutter/material.dart';
import 'package:app_notasorg/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geral'),
        backgroundColor: const Color.fromARGB(255, 74, 177, 233),
      ),
      drawer: const SideBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_img.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: GroupCard(
                  title: 'Trabalho',
                  color: Colors.grey[300]!,
                  onTap: () {
                    Navigator.of(context).pushNamed('group_trabalho');
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25, 
                child: GroupCard(
                  title: 'Pessoal',
                  color: Colors.purple[400]!,
                  onTap: () {
                    Navigator.of(context).pushNamed('group_pessoal');
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: GroupCard(
                  title: 'Estudos',
                  color: Colors.green[400]!,
                  onTap: () {
                    Navigator.of(context).pushNamed('group_estudos');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(76, 0, 0, 0),
        child: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'nova_nota') {
              Navigator.of(context).pushNamed('criar_nota');
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
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