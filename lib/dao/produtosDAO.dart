// import 'package:flutter/cupertino.dart';
// import 'package:registro_lote_casa_de_cha/dao/openDatabaseDB.dart';
// import 'package:registro_lote_casa_de_cha/model/Lote.dart';
// import 'package:sqflite/sqflite.dart';
//
// class ProdutoDAO {
//
//   Future<List<Lote>> getProdutos() async {
//     final Database db = await getDatabase();
//
//     final List<Map<String, dynamic>> maps = await db.query('lote');
//
//     return List.generate(maps.length, (index) {
//       return Lote(
//         maps[index]['id_Lote'],
//         maps[index]['dt_validade'],
//         maps[index]['dt_registro'],
//         maps[index]['qtd_lote'],
//         maps[index]['id_produto'],
//       );
//     });
//   }
//
// }
