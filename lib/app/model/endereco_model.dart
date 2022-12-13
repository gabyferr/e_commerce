import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EnderecoModel {
  int? id;
  String descricao;
  String cep;
  String logradouro;
  String bairro;
  String localidade;
  String uf;

  EnderecoModel({
    this.id,
    required this.descricao,
    required this.cep,
    required this.bairro,
    required this.logradouro,
    required this.localidade,
    required this.uf,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
      'cep': cep,
      'logradouro': logradouro,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
      id: map['id'] != null ? map['id'] as int : null,
      descricao: map['descricao'] as String,
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String,
      bairro: map['bairro'] as String,
      localidade: map['localidade'] as String,
      uf: map['uf'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModel.fromJson(String source) =>
      EnderecoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
