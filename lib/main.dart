import 'package:app_notasorg/controller/cadastro_controller.dart';
import 'package:app_notasorg/controller/login_controller.dart';
import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/view/arquivados_view.dart';
import 'package:app_notasorg/view/cadastro_view.dart';
import 'package:app_notasorg/view/concluidos_view.dart';
import 'package:app_notasorg/view/criarnota_view.dart';
import 'package:app_notasorg/view/group_view.dart';
import 'package:app_notasorg/view/home_view.dart';
import 'package:app_notasorg/view/lixeira_view.dart';
import 'package:app_notasorg/view/login_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final g = GetIt.instance;

void main() {
  g.registerSingleton<LoginController>(LoginController());          //Registrando Controllers
  g.registerSingleton<CadastroController>(CadastroController());
  g.registerSingleton<NotasController>(NotasController());
  runApp(
    DevicePreview(builder: (context) => const MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'login',
      routes: {                                           //Criando as rotas com nomes
        'login': (context) => LoginView(),
        'cadastro': (context) => CadastroView(),
        'home': (context) => HomeView(),
        'concluidos': (context) => ConcluidosView(),
        'lixeira': (context) => LixeiraView(),
        'arquivados': (context) => ArquivadosView(),
        'criar_nota': (context) => CriarnotaView(),
        'group_trabalho': (context) => TrabalhoView(),
        'group_pessoal': (context) => PessoalView(),
        'group_estudos': (context) => EstudosView(),
      },
      builder: DevicePreview.appBuilder,
    );
  }
}
