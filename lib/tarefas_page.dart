import 'package:flutter/material.dart';
import './model/tarefa.dart';

// ignore: must_be_immutable
class TarefaPage extends StatefulWidget {
  TarefaPage({super.key, required this.title});

  String title;

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var _tarefas = <Tarefa>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: const Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return const AlertDialog(title: Text('Adicionar Tarefa'),);
              });
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
