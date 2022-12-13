import 'dart:convert';

import 'package:e_commerce/app/model/pedido_model.dart';
import 'package:e_commerce/app/modules/login/login_controller.dart';
import 'package:e_commerce/app/util/url_util.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class PainelController {
  Future<List<PedidoModel>?> buscarPedidosCliente() async {
    String nomeCliente =
        Modular.get<LoginController>().userAtual.value?.nome ?? '';
    Uri url = Uri.http(UrlUltil.apiServer, '/pedidos/cliente/$nomeCliente');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List temp = jsonDecode(response.body);
      return temp
          .map((e) => PedidoModel.fromMap(e))
          .toList()
          .cast<PedidoModel>();
    }
    return [];
  }
}
