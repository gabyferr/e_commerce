import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProdutoModel {
  int id;
  String nome;
  double valor;
  int quantidade;
  String descricao;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.valor,
    required this.quantidade,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'valor': valor,
      'quantidade': quantidade,
      'descricao': descricao,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      valor: map['valor'] as double,
      quantidade: map['quantidade'] as int,
      descricao: map['descricao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
