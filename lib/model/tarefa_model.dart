// ignore_for_file: unnecessary_getters_setters

class TarefaModel {
  int _id = 0;
  String _descricao = '';
  bool _concluido = false;
  TarefaModel(this._id, this._descricao, this._concluido);

  int get id => _id;

  String get descricao => _descricao;

  set descricao(String descricao) {
    _descricao = descricao;
  }

bool get concluido => _concluido;

  set concluido(concluido) {
    _concluido = concluido;
  }
}
