import 'package:flutter/material.dart';

class ListaLotesCadastradosPage extends StatelessWidget {
  final List<Map<String, dynamic>> lotes;

  const ListaLotesCadastradosPage({Key? key, required this.lotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Lotes Cadastrados'),
      ),
      body: ListView.builder(
        itemCount: lotes.length,
        itemBuilder: (context, index) {
          final lote = lotes[index];
          return ListTile(
            title: Text('ID: ${lote['id_Lote']}'),
            subtitle: Text('Data de Validade: ${lote['dt_validade']}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Ação quando o lote for selecionado
              // Exemplo: Navegar para a página de detalhes do lote
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetalhesLotePage(lote: lote)),
              );
            },
          );
        },
      ),
    );
  }
}

class DetalhesLotePage extends StatelessWidget {
  final Map<String, dynamic> lote;

  const DetalhesLotePage({Key? key, required this.lote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Lote'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${lote['id_Lote']}'),
          Text('Data de Validade: ${lote['dt_validade']}'),
          Text('Data de Registro: ${lote['dt_registro']}'),
          Text('Quantidade do Lote: ${lote['qtd_lote']}'),
          Text('ID do Produto: ${lote['id_produto']}'),
          // Outras informações do lote
        ],
      ),
    );
  }
}
