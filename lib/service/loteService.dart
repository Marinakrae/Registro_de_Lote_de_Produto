import 'dart:convert';
import 'dart:io';

import 'package:registro_lote_casa_de_cha/model/Lote.dart';
import 'package:http/http.dart' as http;
import 'package:registro_lote_casa_de_cha/model/login.dart';

class LoteService{

 Future<Lote> getLotes(Login login) async{
   final response = await http.get(Uri.parse('http://localhost:8080/cha/lote/listar'),
   headers: {
     HttpHeaders.authorizationHeader:  login.token.toString()
   });

   if (response.statusCode == 200){
     var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

     return jsonResponse.map<Lote>( (json)=> Lote.fromJson(json) ).toList();
   } else {
     throw Exception('Falha ao ler Usuario');
   }
 }

}