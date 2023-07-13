import 'package:flutter/material.dart';
import 'package:registro_lote_casa_de_cha/screens/android/registroLote.dart';

import '../../dao/loteDAO.dart';
import '../../model/Lote.dart';
import 'boasVindas.dart';

class ListaLotesCadastradosPage extends StatelessWidget {
  LoteDAO loteDao = LoteDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Lotes Cadastrados'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BoasVindas();
            }));
          },
        ),
      ),
      body: FutureBuilder<List<Lote>>(
        future: loteDao.getLotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os lotes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum lote cadastrado'));
          }

          final lotes = snapshot.data!;

          return ListView.builder(
            itemCount: lotes.length,
            itemBuilder: (context, index) {
              final lote = lotes[index];
              return ListTile(
                title: Text('ID do Lote: ${lote.id_Lote}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Id do Produto: ${lote.id_produto}'),
                    Text('Quantidade: ${lote.qtd_lote}'),
                    Text('Data de Registro: ${lote.dt_registro}'),
                    Text('Data de Validade: ${lote.dt_validade}'),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroLote(lote: lote)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
