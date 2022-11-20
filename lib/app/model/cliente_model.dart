import 'dart:convert';

import 'package:e_commerce/app/model/endereco_model.dart';
import 'package:e_commerce/app/model/usuario_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClienteModel {
  int id;
  String nome;
  UsuarioModel usuario;
  List<EnderecoModel> enderecos;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.usuario,
    required this.enderecos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'usuario': usuario.toMap(),
      'enderecos': enderecos.map((x) => x.toMap()).toList(),
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      usuario: UsuarioModel.fromMap(map['usuario'] as Map<String, dynamic>),
      enderecos: List<EnderecoModel>.from(
        (map['enderecos'] as List<int>).map<EnderecoModel>(
          (x) => EnderecoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
