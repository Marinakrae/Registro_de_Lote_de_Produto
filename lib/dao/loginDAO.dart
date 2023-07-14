import 'package:flutter/cupertino.dart';
import 'package:registro_lote_casa_de_cha/dao/openDatabaseDB.dart';
import 'package:registro_lote_casa_de_cha/model/Lote.dart';
import 'package:sqflite/sqflite.dart';

import '../model/login.dart';

class LoginDAO {
  adicionar(Login login) async {
    final Database db = await getDatabase();
    db.insert('login', login.toMap());
    debugPrint('cadastrou');
  }

  Future<List<Login>> getLogin() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('login');

    return List.generate(maps.length, (index) {
      return Login(
        maps[index]['login'],
        maps[index]['senha'],
        maps[index]['permissao'],
        maps[index]['token'],
      );
    });
  }

  atualizar(Login login) async {
    final Database db = await getDatabase();
    await db.update(
      'login',
      login.toMap(),
      where: 'login = ?',
      whereArgs: [login.login],
    );
    debugPrint('atualizou');
  }
}
