import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsuarioModel {
  int? id;
  String email;
  String senha;
  int permissao;
  
  UsuarioModel({
    this.id,
    required this.email,
    required this.senha,
    required this.permissao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'senha': senha,
      'permissao': permissao,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] as String,
      senha: map['senha'] as String,
      permissao: map['permissao'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
