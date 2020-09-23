import 'package:flutter/material.dart';
import 'package:projeto_ma/rotas.dart';
import 'package:projeto_ma/telas/anuncios.dart';
import 'package:firebase_core/firebase_core.dart';

final ThemeData temaMa = ThemeData(
  primaryColor: Color(0xff321e24),
  accentColor: Color(0xff321e24),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Meu Armário",
    home: Anuncios(),
    initialRoute: "/",
    onGenerateRoute: RotaG.gerarRota,
    theme: temaMa,
    debugShowCheckedModeBanner: false,
  ));
}
