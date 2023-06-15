import 'package:flutter/cupertino.dart';
import 'package:registro_lote_casa_de_cha/dao/openDatabaseDB.dart';
import 'package:registro_lote_casa_de_cha/model/Lote.dart';
import 'package:sqflite/sqflite.dart';

class LoteDAO{
  adicionar(Lote lote) async{
    final Database db = await getDatabase();
    db.insert('lote', lote.toMap());
    debugPrint('cadastrou');
  }

  // Future<List<Lote>> geLotes() async{
  //   final Database db = await getDatabase();
  //
  //   final List<Map<String, dynamic>> maps = await db.query('USUARIO');
  //
  //   return List.generate(maps.length, (i) {
  //     //return Lote(maps[i]['id'], maps[i]['nome'], maps[i]['cpf']);
  //   });
  //
  //
  // }
}