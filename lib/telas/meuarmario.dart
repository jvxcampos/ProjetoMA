import 'package:flutter/material.dart';

class MeuArmario extends StatefulWidget {
  @override
  _MeuArmarioState createState() => _MeuArmarioState();
}

class _MeuArmarioState extends State<MeuArmario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Armário"),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, "/novoanuncio");
        },
      ),
      body: Container(),
    );
  }
}