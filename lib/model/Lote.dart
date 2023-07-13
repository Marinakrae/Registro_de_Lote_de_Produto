class Lote {
  int id_Lote;
  String dt_validade;
  String dt_registro;
  int qtd_lote;
  int id_produto;
  //String imagemBase64;

  Lote(this.id_Lote, this.dt_validade, this.dt_registro, this.qtd_lote, this.id_produto);

  int get quantidade => qtd_lote;

  String get dataValidade => dt_validade;

  String get dataRecebimento => dt_registro;
//, //this.imagemBase64);

  Map<String, dynamic> toMap() {
    return {
      'id_Lote': id_Lote,
      'dt_validade': dt_validade,
      'dt_registro': dt_registro,
      'qtd_lote': qtd_lote,
      'id_produto': id_produto,
      //'imagemBase64': imagemBase64,
    };
  }

  @override
  String toString() {
    return 'Lote{id_Lote: $id_Lote, dt_validade: $dt_validade, dt_registro: $dt_registro, qtd_lote: $qtd_lote, id_produto: $id_produto}';
  }
}
