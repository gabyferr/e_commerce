// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_commerce/app/model/produto_model.dart';

class ItemPedidoModel {
  int? id;
  int quantidade;
  double total;
  ProdutoModel produto;
  
  ItemPedidoModel({
    this.id,
    required this.quantidade,
    required this.total,
    required this.produto,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantidade': quantidade,
      'total': total,
      'produto': produto.toMap(),
    };
  }

  factory ItemPedidoModel.fromMap(Map<String, dynamic> map) {
    return ItemPedidoModel(
      id: map['id'] as int,
      quantidade: map['quantidade'] as int,
      total: map['total'] as double,
      produto: ProdutoModel.fromMap(map['produtoModel'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemPedidoModel.fromJson(String source) => ItemPedidoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
