import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_ma/telas/anuncios.dart';
import 'package:projeto_ma/telas/login.dart';
import 'package:projeto_ma/telas/meuarmario.dart';
import 'package:projeto_ma/telas/novoanuncio.dart';

class RotaG {
  // ignore: missing_return
  static Route<dynamic> gerarRota(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Anuncios());

      case "/login":
        return MaterialPageRoute(builder: (_) => Login());

      case "/meuarmario":
        return MaterialPageRoute(builder: (_) => MeuArmario());

      case "/novoanuncio":
        return MaterialPageRoute(builder: (_) => NovoAnuncio());

      default:
    }
    _erroRota();
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text("Não foi possível encontrar a tela!")),
        body: Center(
          child: Text("Não foi possível encontrar a tela!"),
        ),
      );
    });
  }
}
