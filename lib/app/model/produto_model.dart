import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProdutoModel {
  int id;
  double valor;
  String descricao;
  String imagem;

  ProdutoModel({
    required this.id,
    required this.valor,
    required this.descricao,
    required this.imagem,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'valor': valor,
      'descricao': descricao,
      'imagem': imagem,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'] as int,
      valor: map['valor'] as double,
      descricao: map['descricao'] as String,
      imagem: map['imagem'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
