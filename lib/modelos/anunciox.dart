import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Anunciox{
  String _id;
  String _estado;
  String _categoria;
  String _nomepeca;
  String _preco;
  String _contato;
  String _descricao;
  List<String> _fotos;

Anunciox(){

  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference anuncios = db.collection("meus_anuncios");
  this.id = anuncios.doc().id;

  this.fotos = [];

}

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get contato => _contato;

  set contato(String value) {
    _contato = value;
  }

  String get preco => _preco;

  set preco(String value) {
    _preco = value;
  }

  String get nomepeca => _nomepeca;

  set nomepeca(String value) {
    _nomepeca = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

}