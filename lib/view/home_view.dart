import 'package:flutter/material.dart';
import 'package:app_notasorg/widgets/widgets.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geral'),
        backgroundColor: const Color.fromARGB(255, 74, 177, 233),
        ),
      drawer: const SideBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_img.png"),   // Imagem de fundo
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              GroupCard(                        //Adicionando os grupos
                title: 'Trabalho', 
                color: Colors.grey[300]!, 
                onTap: () {
                  Navigator.of(context).pushNamed('');
                }
              ),

              GroupCard(
                title: 'Pessoal', 
                color: Colors.purple[400]!, 
                onTap: () {
                  Navigator.of(context).pushNamed('');
                }
              ),

              GroupCard(
                title: 'Estudos', 
                color: Colors.green[400]!, 
                onTap: () {
                  Navigator.of(context).pushNamed('');
                }
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
            if (value == 'novo_grupo') {
              // Lógica para novo grupo
            } else if (value == 'nova_nota') {
              // Lógica para nova nota
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'novo_grupo',
              child: Text('Novo Grupo'),
            ),
            const PopupMenuItem(
              value: 'nova_nota',
              child: Text('Nova Nota'),
            ),
          ],
          child: const Icon(Icons.add, size: 50, color: Color.fromARGB(255, 41, 41, 41),),
        ),
      ),
    );
  }
}

