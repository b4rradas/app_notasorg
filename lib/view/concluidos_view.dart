import 'package:app_notasorg/widgets/widgets.dart';
import 'package:flutter/material.dart';


class ConcluidosView extends StatelessWidget {
  const ConcluidosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      
      appBar: AppBar(
        title: Text('Concluidos'),
        backgroundColor: Color.fromARGB(255, 74, 177, 233),
      ),

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
    );
  }
}