import 'package:app_notasorg/controller/cadastro_controller.dart';
import 'package:app_notasorg/controller/login_controller.dart';
import 'package:app_notasorg/view/cadastro_view.dart';
import 'package:app_notasorg/view/home_view.dart';
import 'package:app_notasorg/view/login_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final g = GetIt.instance;

void main() {
  g.registerSingleton<LoginController>(LoginController());
  g.registerSingleton<CadastroController>(CadastroController());
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
      routes: {
        'login': (context) => LoginView(),
        'cadastro': (context) => CadastroView(),
        'home': (context) => HomeView(),
      },
      builder: DevicePreview.appBuilder,
    );
  }
}
