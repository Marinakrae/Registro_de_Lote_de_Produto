import 'dart:convert';

import 'package:registro_lote_casa_de_cha/model/Lote.dart';

class LoteService{

 Future<List<Lote>> getLotes() async{
   final response = await http.get(Uri.parse('http:10.0.2.2:8080/lote/listar'));

   if (response.statusCode === 200){
     var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

     return jsonResponse.map<Lote>( (json)=> Lote.fromJson(json) ).toList();
   } else {
     throw Exception('Falha ao ler Usuario');
   }
 }

}