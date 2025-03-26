import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geral'),
        backgroundColor: const Color.fromARGB(255, 91, 153, 186),
        ),
      drawer: const NavigationDrawer()
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
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

  Widget buildMenuItens(BuildContext context) => Column(
    children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Home'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.check_box_outlined),
        title: const Text('Concluidos'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.delete_outline),
        title: const Text('Lixeira'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.archive_outlined),
        title: const Text('Arquivados'),
        onTap: () {},
      )
    ],
  );
}