import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];

  _opcaoMenu(String opcaoEscolhida) {
    switch (opcaoEscolhida) {
      case "Meu Armário":
        Navigator.pushNamed(context, "/meuarmario");
        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Sair":
        _sairUser();
        break;
    }
  }

  _sairUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(context, "/");
  }

  Future _verUserLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var loginYes = await auth.currentUser;

    if (loginYes == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Meu Armário", "Sair"];
    }
  }

  @override
  void initState() {
    super.initState();

    _verUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nosso Armário"),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _opcaoMenu,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child: Text("Nosso Armário"),
      ),
    );
  }
}
