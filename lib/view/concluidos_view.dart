import 'package:app_notasorg/view/home_view.dart';
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
    );
  }
}