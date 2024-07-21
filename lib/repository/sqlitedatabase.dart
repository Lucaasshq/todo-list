import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SQLiteDataBase {
  static Database? db;

  Future<Database> get getDataBase async {
    if (db == null) {
      return _initDataBase;
    } else {
      return db!;
    }
  }

  final Map<int, String> _scripts = {
    1: '''CREATE TABLE tarefas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          concluido INTEGER);'''
  };

  Future<Database> get _initDataBase async {
    var db = await openDatabase(
      path.join(await getDatabasesPath(), 'tarefa.db'),
      version: _scripts.length,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    for (var i = 1; i <= _scripts.length; i++) {
      await db.execute(_scripts[i]!);
      debugPrint(_scripts[i]);
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (var i = oldVersion + 1; i <= _scripts.length; i++) {
      await db.execute(_scripts[i]!);
      debugPrint(_scripts[i]);
    }
  }
}
