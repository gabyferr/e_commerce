// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:e_commerce/app/model/cliente_model.dart';
import 'package:e_commerce/app/model/endereco_model.dart';
import 'package:e_commerce/app/model/item_pedido_model.dart';

class PedidoModel {
  int id;
  ClienteModel cliente;
  String dataEfetuado;
  double total;
  List<ItemPedidoModel> itens;
  EnderecoModel endereco;
  int status;

  PedidoModel({
    required this.id,
    required this.cliente,
    required this.dataEfetuado,
    required this.total,
    required this.itens,
    required this.endereco,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cliente': cliente.toMap(),
      'dataEfetuado': dataEfetuado,
      'total': total,
      'itens': itens.map((x) => x.toMap()).toList(),
      'endereco': endereco.toMap(),
      'status': status,
    };
  }

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      id: map['id'] as int,
      cliente: ClienteModel.fromMap(map['cliente'] as Map<String,dynamic>),
      dataEfetuado: map['dataEfetuado'] as String,
      total: map['total'] as double,
      itens: List<ItemPedidoModel>.from((map['itens'] as List<int>).map<ItemPedidoModel>((x) => ItemPedidoModel.fromMap(x as Map<String,dynamic>),),),
      endereco: EnderecoModel.fromMap(map['endereco'] as Map<String,dynamic>),
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoModel.fromJson(String source) =>
      PedidoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
