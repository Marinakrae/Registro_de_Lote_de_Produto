import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE lote (id_Lote INTEGER PRIMARY KEY, dt_validade TEXT, dt_registro TEXT, qtd_lote INTEGER, id_produto INTEGER)');
      db.execute('CREATE TABLE login (id INTEGER PRIMARY KEY, login TEXT, senha TEXT, permissao TEXT, token TEXT)');
    }, //imagemBase64 TEXT
    version: 9,
  );
}


