import 'package:app_notasorg/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LixeiraView extends StatelessWidget {
  const LixeiraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Lixeira'),
        backgroundColor: Color.fromARGB(255, 74, 177, 233),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_img.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              ListCard(
                title: "Trabalho",
                color: Colors.grey[300]!,
                onTap: () {
                  Navigator.of(context).pushNamed('trabalho');
                },
              ),
              ListCard(
                title: "Pessoal",
                color: Colors.purple[400]!,
                onTap: () {
                  Navigator.of(context).pushNamed('pessoal');
                },
              ),
              ListCard(
                title: "Estudos",
                color: Colors.green[400]!,
                onTap: () {
                  Navigator.of(context).pushNamed('estudos');
                },
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