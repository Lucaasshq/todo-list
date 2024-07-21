import 'package:todolist/model/tarefa_model.dart';
import 'package:todolist/repository/sqlitedatabase.dart';

class TarefaSQLiteRepository {
  final List<TarefaModel> _tarefas = [];
  Future<List<TarefaModel>> getDados() async {
    var db = await SQLiteDataBase().getDataBase;
    var result = await db.rawQuery('SELECT id, descricao, concluido FROM tarefas');
    for (var element in result) {
      _tarefas.add(
        TarefaModel(
          int.parse(element['id'].toString()),
          element['descricao'].toString(),
          element['concluido'] == 1,
        ),
      );
    }
    return _tarefas;
  }

  Future<void> salvar(TarefaModel tarefaModel) async {
    var db = await SQLiteDataBase().getDataBase;
    db.rawInsert('INSERT INTO tarefas (descricao, concluido) values(?,?)', [
      tarefaModel.descricao,
      tarefaModel.concluido,
    ]);
  }

  Future<void> atualizar(TarefaModel tarefaModel) async {
    var db = await SQLiteDataBase().getDataBase;
    await db.rawUpdate('UPDATE tarefas SET descricao = ?, concluido = ? WHERE id = ?', [
      tarefaModel.descricao,
      tarefaModel.concluido,
      tarefaModel.id,
    ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().getDataBase;
    db.rawDelete('DELETE FROM tarefas WHERE id = ?', [id]);
  }
}
