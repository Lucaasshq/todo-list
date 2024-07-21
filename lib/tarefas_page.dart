import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/colors/colors.dart';
import 'package:todolist/repository/tarefa_repository.dart';
import 'model/tarefa_model.dart';
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
  TarefaSQLiteRepository tarefaRepository = TarefaSQLiteRepository();
  List<TarefaModel> _tarefas = <TarefaModel>[];
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    getTarefas();
  }

  getTarefas() async {
    _tarefas = await TarefaSQLiteRepository().getDados();
    setState(() {});
  }

  void addTask() async {
    await tarefaRepository.salvar(TarefaModel(0, descricaoController.text, isChecked));
    getTarefas();
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pretoP,
        appBar: AppBar(
          backgroundColor: AppColors.azulp,
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
          leading: IconButton(
              onPressed: () {
                exit(0);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hoje',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat.yMMMMEEEEd().format(DateTime.now()),
                    style: const TextStyle(color: AppColors.brancop, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext context, index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    background: Container(
                      color: Colors.red[400],
                      child: const Icon(Icons.delete_forever),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        tarefaRepository.remover(tarefa.id);
                        _tarefas.removeAt(index);
                        getTarefas();
                      });
                    },
                    key: Key(tarefa.id.toString()),
                    child: Card(
                      shape: const BeveledRectangleBorder(),
                      color: AppColors.pretop2,
                      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                      child: ListTile(
                        title: Text(
                          tarefa.descricao,
                          style: TextStyle(
                              decoration: tarefa.concluido ? TextDecoration.lineThrough : TextDecoration.none,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brancop),
                        ),
                        leading: Checkbox(
                          activeColor: AppColors.brancop,
                          checkColor: AppColors.pretoP,
                          value: tarefa.concluido,
                          onChanged: (newbool) {
                            setState(() {
                              _tarefas[index] = TarefaModel(tarefa.id, tarefa.descricao, newbool!);
                              tarefaRepository.atualizar(_tarefas[index]);
                              getTarefas();
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
                          decoration: const InputDecoration(border: OutlineInputBorder()),
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
      ),
    );
  }
}
