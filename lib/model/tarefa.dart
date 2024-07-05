import 'package:flutter/material.dart';

class Tarefa {
  final _id = UniqueKey().toString();
  String _descricao = '';
  bool _concluido = false;
  Tarefa(this._descricao, this._concluido);

  String get id => _id;

  // ignore: unnecessary_getters_setters
  String get descricao => _descricao;

  set descricao(String descricao) {
    _descricao = descricao;
  }

  bool get concluido => _concluido;

  set concluido(bool concluido) {
    _concluido = concluido;
  }
}
