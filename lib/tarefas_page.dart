import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/colors/colors.dart';
import 'package:todolist/repository/tarefa_repository.dart';
import './model/tarefa.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TarefaPage extends StatefulWidget {
  TarefaPage({super.key, required this.title});

  String title;

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  TextEditingController descricaoController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var tarefaRepository = TarefaRepository();
  final List<Tarefa> _tarefa = <Tarefa>[];
  bool isChecked = false;

  void addTask() {
    tarefaRepository.adicionar(Tarefa(descricaoController.text, isChecked));
    _tarefa.add(Tarefa(descricaoController.text, isChecked));
    Navigator.pop(context);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pretoP,
      appBar: AppBar(
        backgroundColor: AppColors.azulp,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
      ),
      // ignore: avoid_unnecessary_containers
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Text(
                'Hoje',
                style: TextStyle(
                  color: AppColors.brancop,
                ),
              ),
              Text(
                DateFormat.yMMMMEEEEd().format(DateTime.now()),
                style: const TextStyle(color: AppColors.brancop),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefa.length,
              itemBuilder: (BuildContext context, index) {
                var tarefa = _tarefa[index];
                return Dismissible(
                  background: Container(
                    color: Colors.red[400],
                    child: const Icon(Icons.delete_forever),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      tarefaRepository.remove(tarefa.id);
                      _tarefa.removeAt(index);
                    });
                  },
                  key: Key(tarefa.id),
                  child: Card(
                    shape: const BeveledRectangleBorder(),
                    color: AppColors.pretop2,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                    child: ListTile(
                      title: Text(
                        tarefa.descricao,
                        style: TextStyle(
                            decoration: tarefa.concluido
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontWeight: FontWeight.w700,
                            color: AppColors.brancop),
                      ),
                      leading: Checkbox(
                        activeColor: AppColors.brancop,
                        checkColor: AppColors.pretoP,
                        value: tarefa.concluido,
                        onChanged: (newbool) {
                          setState(() {
                            tarefa.concluido = newbool!;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.azulp,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text('Adicionar Tarefa'),
                    content: Form(
                      key: _form,
                      child: TextFormField(
                        controller: descricaoController,
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: addTask,
                          child: const Text(
                            'Adicionar',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  );
                });
          },
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add_task,
            size: 35,
          )),
    );
  }
}
