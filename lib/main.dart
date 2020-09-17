import 'package:flutter/material.dart';
import 'package:projeto_ma/telas/login.dart';
import 'package:firebase_core/firebase_core.dart';

final ThemeData temaMa = ThemeData(
  primaryColor: Color(0xff321e24),
  accentColor: Color(0xff321e24),
);

void main() 
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
  title: "Meu Armário",
  home: Login(),
  theme: temaMa ,
  debugShowCheckedModeBanner: false,
));

}