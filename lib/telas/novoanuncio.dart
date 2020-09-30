import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_ma/telas/BotaoCustomizado.dart';
import 'package:projeto_ma/telas/InputCustomizado.dart';
import 'dart:io';

import 'package:validadores/Validador.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  List<File> _listaImagens = List();
  List<DropdownMenuItem<String>> _listaEstados = List();
  List<DropdownMenuItem<String>> _listaCategorias = List();

  final _formKey = GlobalKey<FormState>();

  String _itemSelecionadoEstado;
  String _itemSelecionadoCategoria;

  _selecionarImagem() async {
    File imagemSelecionada =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  void initState(){
    super.initState();
    _carregarItens();
  }

  _carregarItens(){

    _listaCategorias.add(
      DropdownMenuItem(child: Text("Camiseta"), value: "camiseta",)
    );

    _listaCategorias.add(
      DropdownMenuItem(child: Text("Blusa"), value: "blusa",)
    );

    _listaCategorias.add(
      DropdownMenuItem(child: Text("Calça"), value: "calca",)
    );

    _listaCategorias.add(
      DropdownMenuItem(child: Text("Sapato"), value: "sapato",)
    );

    for( var estado in Estados.listaEstadosAbrv)
    _listaEstados.add(
      DropdownMenuItem(child: Text(estado), value: estado)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Peça"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormField<List>(
                  initialValue: _listaImagens,
                  validator: (imagens) {
                    if (imagens.length == 0) {
                      return "Selecione uma imagem!";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _listaImagens.length + 1,
                              itemBuilder: (context, indice) {
                                if (indice == _listaImagens.length) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _selecionarImagem();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Color(0Xff5B4051),
                                        radius: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.add_a_photo,
                                              size: 40,
                                              color: Color(0xff321e24),
                                            ),
                                            Text(
                                              "Adicionar",
                                              style: TextStyle(
                                                  color: Color(0xff321e24)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (_listaImagens.length > 0) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder:(context) => Dialog(
                                               child: Column(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                 Image.file(_listaImagens[indice]),
                                                 FlatButton(
                                                   child: Text ("Excluir"),
                                                   textColor: Color(0xff321e24),
                                                   onPressed: (){
                                                     setState(() {
                                                       _listaImagens.removeAt(indice);
                                                       Navigator.of(context).pop();
                                                     });
                                                   },
                                                   )
                                               ]), 
                                              )
                                              );
                                          },
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: FileImage(
                                                _listaImagens[indice]),
                                            child: Container(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.5),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xff321e24),
                                                )),
                                          )));
                                }
                                return Container();
                              }),
                        ),
                        if (state.hasError)
                          Container(
                            child: Text(
                              "[${state.errorText}]",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                      ],
                    );
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                              value: _itemSelecionadoEstado,
                              hint: Text("Estados"),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                              ),
                              items: _listaEstados,
                              validator: (valor){
                                return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                                .valido(valor);
                              },
                              onChanged: (valor){
                                setState(() {
                                  _itemSelecionadoEstado = valor;
                                });
                              },
                        ),
                    ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                              value: _itemSelecionadoCategoria,
                              hint: Text("Categorias"),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                              ),
                              items: _listaCategorias,
                              validator: (valor){
                                return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                                .valido(valor);
                              },
                              onChanged: (valor){
                                setState(() {
                                  _itemSelecionadoCategoria = valor;
                                });
                              },
                        ),
                    ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(bottom:15, top: 15),
                  child:InputCustomizado(
                  hint: "Nome da peça",
                  validator: (valor){
                    return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                                .valido(valor);
                  },
                ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:15),
                  child:InputCustomizado(
                  hint: "Preço",
                  type: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    RealInputFormatter(centavos: true)
                  ],
                  validator: (valor){
                    return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                                .valido(valor);
                  },
                ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:15),
                  child:InputCustomizado(
                  hint: "Contato",
                  type: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  validator: (valor){
                    return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                                .valido(valor);
                  },
                ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom:15),
                  child:InputCustomizado(
                  hint: "Descrição",
                  maxLines: null,
                  validator: (valor){
                    return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                                .maxLength(180, msg: "Máximo de 180 caracteres")
                                .valido(valor);
                  },
                ),
                ),
                BotaoCustomizado(
                  texto: "Cadastrar Peça",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
