import 'dart:convert';

import 'package:flutter/widgets.dart';

class LoginService {

  final String API_REST = "http://10.0.2.2.8080";

  Map<String, String> headers = <String, String>{
    "Contet-type":"application/json",
  };

  Future<bool> login (String login, String senha) async {
    final conteudo = json.encode(<String, String>{'login': login, 'senha': senha});
    final resposta = await http.post(Uri.parse(API_REST+"/login"), headers: headers, body: const);
    debugPrint("Status code:"+resposta.statusCode.toString());
    debugPrint("Valor: "+resposta.body.toString());

    if(resposta.statusCode == 200){
      Login usuarioLogado = Login.fromJson(jsonDecode(resposta.body));

      new LoginDAO().adicionar(usuarioLogado);
      return true;
    }

    return false;
  }



}