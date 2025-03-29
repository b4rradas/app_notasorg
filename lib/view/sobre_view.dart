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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center( 
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 213, 195),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage("assets/Lucas_Hisaimtsu_Profile.jpg"),
                  ),
                  SizedBox(height: 20), 
                  Text(
                    'Lucas Hisaimtsu', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Desenvolvedor do aplicativo NotasOrg.', // Adicionar mais informações
                    textAlign: TextAlign.center,
                  ),
                  // Adicionar mais widgets:
                  //Contato, Sobre o App
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}