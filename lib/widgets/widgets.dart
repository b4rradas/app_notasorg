import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {   //Criando Drawer - SideBar
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) => Drawer(                   
    backgroundColor: const Color.fromARGB(255, 74, 177, 233),
    child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItens(context)
        ],
      ),
    ),
  );

  Widget buildHeader(BuildContext context) => Container(    //Header da SideBar
      padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top
    ),
  );

  Widget buildMenuItens(BuildContext context) => Wrap(    //Itens da SideBar
    runSpacing: 15,
    children: [
      ListTile(
        leading: Icon(Icons.home_outlined, size: 30,),
        title: Text('Geral', style: TextStyle(fontSize: 22),),
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).pushNamed('home');
          },
      ),

      ListTile(
        leading: const Icon(Icons.check_box_outlined, size: 30,),
        title: const Text('Concluidos', style: TextStyle(fontSize: 22),),
        onTap: () {
          Navigator.pop(context);

          Navigator.of(context).pushNamed('concluidos');
        } 
      ),

      ListTile(
        leading: const Icon(Icons.delete_outline, size: 30,),
        title: const Text('Lixeira', style: TextStyle(fontSize: 22),),
        onTap: () {
          Navigator.pop(context);

          Navigator.of(context).pushNamed('lixeira');
        },
      ),

      ListTile(
        leading: const Icon(Icons.archive_outlined, size: 30,),
        title: const Text('Arquivados', style: TextStyle(fontSize: 22),),
        onTap: () {
          Navigator.pop(context);

          Navigator.of(context).pushNamed('arquivados');
        },
      ),

      const Divider(color: Colors.black38,),

      ListTile(
        leading: const Icon(Icons.person, size: 30,),
        title: const Text('Sobre', style: TextStyle(fontSize: 22),),
        onTap: () {
          Navigator.pop(context);

          Navigator.of(context).pushNamed('sobre');
        },
      ),

      ListTile(
        leading: Icon(Icons.exit_to_app, size: 30,),
        title: Text('Sair', style: TextStyle(fontSize: 22),),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
        },
      )
    ],
  );
}


class GroupCard extends StatelessWidget {     //Crição dos grupos
  final String title;
  final Color color;
  final VoidCallback onTap;

  const GroupCard({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color headerColor = darkenColor(color, 0.7);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          //Nome Grupo
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            width: 160,
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Corpo Grupo
          Container(
            width: 160,
            height: 150,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                // Notas Ilustração
                Positioned(top: 10, left: 10, child: _buildNote(Colors.blue)),
                Positioned(top: 10, right: 10, child: _buildNote(Colors.green)),
                Positioned(bottom: 10, left: 10, child: _buildNote(Colors.orange)),
                Positioned(bottom: 10, right: 10, child: _buildNote(Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Criar Notas Ilustração
  Widget _buildNote(Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}


Color darkenColor(Color color, double fator) {  //Escurecer a cor para o topo do grupo
  HSVColor hsv = HSVColor.fromColor(color);
  HSVColor novaCor = hsv.withValue((hsv.value * fator).clamp(0.0, 1.0));
  return novaCor.toColor();
}


class ListCard extends StatelessWidget {    //Criação dos cartões de lista
  final String title;
  final Color color;
  final VoidCallback onTap;

  const ListCard({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
