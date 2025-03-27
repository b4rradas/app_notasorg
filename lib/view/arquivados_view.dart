import 'package:app_notasorg/widgets/widgets.dart';
import 'package:flutter/material.dart';


class ArquivadosView extends StatelessWidget {
  const ArquivadosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_img.png"), // Imagem de fundo
            fit: BoxFit.cover, // Preenche toda a tela
          ),
        ),
      ),
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Arquivados'),
        backgroundColor: Color.fromARGB(255, 74, 177, 233),
      ),
    );
  }
}