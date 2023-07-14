import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:registro_lote_casa_de_cha/screens/android/registroLote.dart';
import 'package:registro_lote_casa_de_cha/service/produtoService.dart';
import 'package:http/http.dart' as http;
import 'package:registro_lote_casa_de_cha/model/Produto.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => ListaProdutosCadastradosPage();
}

class ListaProdutosCadastradosPage extends State<MyApp> {
  late Future<List<Produtos>> futureProduto;

  @override
  void initState() {
    super.initState();
    futureProduto = ProdutoService().getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Produtos'),
        ),
        body: Center(
          child: FutureBuilder<List<Produtos>>(
            future: futureProduto,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final produtos = snapshot.data!;
                return ListView.builder(
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final produto = produtos[index];
                    return ListTile(
                      title: Text(produto.title),
                      subtitle: Text(produto.description),
                      // Adicione mais detalhes do produto aqui, conforme necessário
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
