import 'dart:convert';
import 'package:e_commerce/app/components/snackbar_comp.dart';
import 'package:e_commerce/app/model/cliente_model.dart';
import 'package:e_commerce/app/model/usuario_model.dart';
import 'package:e_commerce/app/util/url_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:http/http.dart' as http;

class LoginController {
  final userAtual = RxNotifier<ClienteModel?>(null);
  void setUser(ClienteModel? value) => userAtual.value = value;
  bool get isLogado => userAtual.value?.usuario != null;

  String? errorEmail = '';
  String? errorSenha = '';

  void validarEmail(value) {
    if (value.length < 6) {
      errorEmail = 'Email inválido';
    } else {
      errorEmail = null;
    }
  }

  void validarSenha(value) {
    if (value.length < 4) {
      errorSenha = 'Senha inválido';
    } else {
      errorSenha = null;
    }
  }

  Future<void> fazerLogin(UsuarioModel usuario, BuildContext context) async {
    if (errorEmail != null && errorSenha != null) {
      Uri url = Uri.http(UrlUltil.apiServer, '/login');
      http.Response response = await http.post(
        url,
        body: jsonEncode(usuario.toMap()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        setUser(ClienteModel.fromJson(response.body));
        return Modular.to.pop();
      }
    }
    SnackbarComp.build(
      context,
      'Erro',
      'Credenciais inválidas',
    );
  }

  void deslogar() {
    setUser(null);
    Modular.to.pop();
    Modular.to.navigate('/');
  }
}
