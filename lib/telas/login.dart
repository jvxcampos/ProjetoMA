import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projeto_ma/modelos/Userma.dart';
import 'package:projeto_ma/telas/BotaoCustomizado.dart';
import 'package:projeto_ma/telas/InputCustomizado.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail =
      TextEditingController(text: "joaovitorcampos1299@gmail.com");
  TextEditingController _controllerSenha =
      TextEditingController(text: "12345678");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarUserma(Userma userma) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: userma.email, password: userma.senha)
        .then((firebaseUser) {
      //redireciona para a tela principal
      Navigator.pushReplacementNamed(context, "/");
    });
  }

  _logarUserma(Userma userma) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
      email: userma.email,
      password: userma.senha,
    )
        .then((firebaseUser) {
      //redireciona para a tela principal
      Navigator.pushReplacementNamed(context, "/");
    });
  }

  _validarCampos() {
//Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 7) {
        //Configura usuario
        Userma userma = Userma();
        userma.email = email;
        userma.senha = senha;

        //cadastrar ou logar
        if (_cadastrar) {
          //Cadastrar
          _cadastrarUserma(userma);
        } else {
          //Logar
          _logarUserma(userma);
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha! Com pelo menos caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset(
                  "imagens/logo_teste.png",
                  width: 200,
                  height: 150,
                ),
              ),
              InputCustomizado(
                controller: _controllerEmail,
                hint: "E-mail",
                autofocus: true,
                type: TextInputType.emailAddress,
              ),
              InputCustomizado(
                controller: _controllerSenha,
                hint: "Senha",
                maxLines: 1,
                obscure: true,         
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Logar"),
                  Switch(
                    value: _cadastrar,
                    onChanged: (bool valor) {
                      setState(() {
                        _cadastrar = valor;
                        _textoBotao = "Entrar";
                        if (_cadastrar) {
                          _textoBotao = "Cadastrar";
                        }
                      });
                    },
                  ),
                  Text("Cadastrar"),
                ],
              ),
              BotaoCustomizado(
                texto: _textoBotao,
                onPressed:  (){_validarCampos();
                }),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _mensagemErro,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
