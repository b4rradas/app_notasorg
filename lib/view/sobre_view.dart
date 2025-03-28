import 'package:app_notasorg/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  const SobreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Sobre'),
        backgroundColor: Color.fromARGB(255, 74, 177, 233),
      ),
      body: Stack( // Usando Stack para sobrepor o background e o container centralizado
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center( // Usando Center para centralizar o container
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 213, 195),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ajusta o tamanho da coluna ao conteúdo
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage("assets/Lucas_Hisaimtsu_Profile.jpg"),
                  ),
                  SizedBox(height: 20), // Espaçamento entre o avatar e o texto
                  Text(
                    'Lucas Hisaimtsu', // Adicione o nome ou informações aqui
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Desenvolvedor do aplicativo NotasOrg.', // Adicione mais informações aqui
                    textAlign: TextAlign.center,
                  ),
                  // Adicione mais widgets aqui, se necessário
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}