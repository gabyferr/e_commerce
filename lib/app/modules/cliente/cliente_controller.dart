import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:e_commerce/app/components/snackbar_comp.dart';
import 'package:e_commerce/app/modules/login/login_controller.dart';
import 'package:e_commerce/app/util/url_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce/app/model/cliente_model.dart';

class ClienteController {
  Future<void> cadastrar(ClienteModel cliente, BuildContext context) async {
    if (cliente.nome == '' ||
        cliente.usuario.email == '' ||
        cliente.usuario.senha == '' ||
        cliente.enderecos.first.bairro == '' ||
        cliente.enderecos.first.cep == '' ||
        cliente.enderecos.first.descricao == '' ||
        cliente.enderecos.first.localidade == '' ||
        cliente.enderecos.first.logradouro == '' ||
        cliente.enderecos.first.uf == '') {
      SnackbarComp.build(
        context,
        'Atencao',
        'todos os campos sao obrigatorios',
      );
    }

    Uri url = Uri.http(UrlUltil.apiServer, '/cliente');
    http.Response response = await http.post(
      url,
      body: jsonEncode(cliente.toMap()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      SnackbarComp.build(context, '', 'Cadastrado com sucesso!', AnimatedSnackBarType.success);
      Modular.get<LoginController>().setUser(cliente);
      Modular.to.pop();
    } else {
      SnackbarComp.build(
        context,
        'Erro',
        'nao foi possivel enviar os dados para api',
      );
    }
  }
}
