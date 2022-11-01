import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClienteModel {
  String email;
  String senha;

  ClienteModel({
    required this.email,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'senha': senha,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      email: map['email'] as String,
      senha: map['senha'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
