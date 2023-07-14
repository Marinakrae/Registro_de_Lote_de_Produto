import 'dart:convert';
import 'dart:io';

import 'package:registro_lote_casa_de_cha/model/Lote.dart';
import 'package:http/http.dart' as http;
import 'package:registro_lote_casa_de_cha/model/Produto.dart';
import 'package:registro_lote_casa_de_cha/model/login.dart';

class ProdutoService{

  Future<List<Produtos>> getProdutos() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = jsonDecode(response.body);

      List<Produtos> produtos = decodedData.map((item) => Produtos.fromJson(item)).toList();

      return produtos;
    } else {
      throw Exception('Falha ao ler Produtos');
    }
  }

}