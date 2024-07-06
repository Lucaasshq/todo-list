import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/repository/tarefa_repository.dart';
import './model/tarefa.dart';

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
  List<Tarefa> _tarefa = <Tarefa>[
    Tarefa('Criar um aplicativo Todo-List', false),
    Tarefa('Iniciar as aulas na faculdade', false),
    Tarefa('Conseguir um estagio', false),
    Tarefa('Conseguir um estagio', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tarefa.length,
                itemBuilder: (BuildContext context, index) {
                  var tarefa = _tarefa[index];
                  return Dismissible(
                    key: Key(tarefa.id),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      leading: Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
                        onPressed: () {
                          tarefaRepository.adicionar(
                              Tarefa(descricaoController.text, false));
                          _tarefa.add(tarefaRepository.listaTarefas() as Tarefa); 
                          Navigator.pop(context);

                          setState(() {});
                        },
                        child: const Text(
                          'Adicionar',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                );
              });
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
