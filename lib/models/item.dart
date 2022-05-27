import 'dart:core';

class Item {
  final String nome;
  String usuario = "";
  bool isComprado = false;

  Item(this.nome,{this.usuario = "", this.isComprado = false});
}
