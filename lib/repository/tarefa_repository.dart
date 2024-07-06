import 'package:todolist/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefa = [];

  adicionar(Tarefa tarefa) {
    _tarefa.add(tarefa);
  }

  List<Tarefa> listaTarefas() {
    return _tarefa;
  }
}
