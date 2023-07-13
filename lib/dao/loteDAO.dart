import 'package:flutter/cupertino.dart';
import 'package:registro_lote_casa_de_cha/dao/openDatabaseDB.dart';
import 'package:registro_lote_casa_de_cha/model/Lote.dart';
import 'package:sqflite/sqflite.dart';

class LoteDAO {
  adicionar(Lote lote) async {
    final Database db = await getDatabase();
    db.insert('lote', lote.toMap());
    debugPrint('cadastrou');
  }

  Future<List<Lote>> getLotes() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('lote');

    return List.generate(maps.length, (index) {
      return Lote(
        maps[index]['id_Lote'],
        maps[index]['dt_validade'],
        maps[index]['dt_registro'],
        maps[index]['qtd_lote'],
        maps[index]['id_produto'],
      );
    });
  }

  atualizar(Lote lote) async {
    final Database db = await getDatabase();
    await db.update(
      'lote',
      lote.toMap(),
      where: 'id_Lote = ?',
      whereArgs: [lote.id_Lote],
    );
    debugPrint('atualizou');
  }
}
