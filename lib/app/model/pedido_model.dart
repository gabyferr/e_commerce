// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_commerce/app/model/cliente_model.dart';
import 'package:e_commerce/app/model/item_pedido_model.dart';

class PedidoModel {
  int? id;
  ClienteModel cliente;
  String dataEfetuado;
  double total;
  int tipoPagamento;
  List<ItemPedidoModel> itens;
  int status;

  PedidoModel({
    this.id,
    required this.cliente,
    required this.dataEfetuado,
    required this.total,
    required this.tipoPagamento,
    required this.itens,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cliente': cliente.toMap(),
      'dataEfetuado': dataEfetuado,
      'total': total,
      'tipoPagamento': tipoPagamento,
      'itens': itens.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      id: map['id'] != null ? map['id'] as int : null,
      cliente: ClienteModel.fromMap(map['cliente'] as Map<String,dynamic>),
      dataEfetuado: map['dataEfetuado'] as String,
      total: map['total'] as double,
      tipoPagamento: map['tipoPagamento'] as int,
      itens: List<ItemPedidoModel>.from((map['itens']).map<ItemPedidoModel>((x) => ItemPedidoModel.fromMap(x as Map<String,dynamic>),),),
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoModel.fromJson(String source) =>
      PedidoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
