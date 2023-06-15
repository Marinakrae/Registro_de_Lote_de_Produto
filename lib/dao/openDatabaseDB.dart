import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE lote (id_Lote INTEGER PRIMARY KEY, dt_validade TEXT, dt_registro TEXT, qtd_lote INTEGER, id_produto INTEGER)');
    }, //imagemBase64 TEXT
    version: 8,
  );
}


