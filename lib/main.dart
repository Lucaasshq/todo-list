import 'package:flutter/material.dart';
import 'package:todolist/colors/colors.dart';
import 'package:todolist/tarefas_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, primary: AppColors.pretop2),
        useMaterial3: true,
      ),
      home: TarefaPage(title: 'Todo List'),
    );
  }
}
