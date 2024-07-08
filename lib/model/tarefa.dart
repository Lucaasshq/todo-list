import 'package:flutter/material.dart';

class Tarefa {
  final String _id = UniqueKey().toString();
  String _descricao = '';
  bool _concluido = false;
  Tarefa(this._descricao, this._concluido);

  String get id => _id;

  // ignore: unnecessary_getters_setters
  String get descricao => _descricao;


  set descricao(String descricao) {
    _descricao = descricao;
  }
  // ignore: unnecessary_getters_setters
  bool get concluido => _concluido;

  set concluido(bool concluido) {
    _concluido = concluido;
  }
}
