import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_img.png"),   // Imagem de fundo
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('concluidos');
            },
            icon: ImageIcon(AssetImage("assets/icons/circle-plus.svg"))),
        ),
      ),
      appBar: AppBar(
        title: Text('Geral'),
        backgroundColor: const Color.fromARGB(255, 74, 177, 233),
        ),
      drawer: const SideBar()
      
    );
  }
}

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

  Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top
    ),
  );

  Widget buildMenuItens(BuildContext context) => Wrap(
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
      )
    ],
  );
}