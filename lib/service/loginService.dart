import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:registro_lote_casa_de_cha/dao/loginDAO.dart';
import 'package:registro_lote_casa_de_cha/screens/android/boasVindas.dart';

import '../model/login.dart';

class LoginService {

  final String API_REST = 'http://localhost:8080/cha/login';

  Map<String, String> headers = <String, String>{
    "Content-type":"application/json",
  };


  Future<Login> login(String login, String senha) async {
    final Map<String, dynamic> loginData = {
      'nome_usuario': '',
      'login': login,
      'senha': senha,
      'permissao': 'ADMIN',
      'ativo': true,
    };

    final conteudo = json.encode(loginData);

    final resposta = await http.post(Uri.parse(API_REST), headers: headers, body: conteudo);

    debugPrint("Status code:" + resposta.statusCode.toString());
    debugPrint("Valor: " + resposta.body.toString());

    if (resposta.statusCode == 200) {
      Login usuarioLogado = Login.fromJson(jsonDecode(resposta.body));

      new LoginDAO().atualizar(usuarioLogado);
      new LoginDAO().adicionar(usuarioLogado);

      return usuarioLogado;
    }

    return Future.error("Erro ao fazer login");
  }

}