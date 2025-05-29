import 'package:app_notasorg/controller/cadastro_controller.dart';
import 'package:app_notasorg/controller/login_controller.dart';
import 'package:app_notasorg/controller/notas_controller.dart';
import 'package:app_notasorg/firebase_options.dart';
import 'package:app_notasorg/view/arquivados_view.dart';
import 'package:app_notasorg/view/cadastro_view.dart';
import 'package:app_notasorg/view/concluidos_view.dart';
import 'package:app_notasorg/view/criarnota_view.dart';
import 'package:app_notasorg/view/esqueci_senha_view.dart';
import 'package:app_notasorg/view/group_view.dart';
import 'package:app_notasorg/view/home_view.dart';
import 'package:app_notasorg/view/lixeira_view.dart';
import 'package:app_notasorg/view/login_view.dart';
import 'package:app_notasorg/view/pesquisa_view.dart';
import 'package:app_notasorg/view/sobre_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final g = GetIt.instance;

Future<void> main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  g.registerSingleton<CadastroController>(CadastroController());
  g.registerSingleton<LoginController>(LoginController());          //Registrando Controllers
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
        'sobre':(context) => SobreView(),
        'esqueci_senha': (context) => EsqueciSenhaView(),
        'pesquisa_view': (context) => PesquisaView(),
      },
      builder: DevicePreview.appBuilder,
    );
  }
}
