import 'package:e_commerce/app/components/snackbar_comp.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce/app/model/cliente_model.dart';

class ClienteController {
  void cadastrar(ClienteModel cliente, BuildContext context) async {
    Uri url = Uri.http('localhost:3000', '/cliente');
    http.Response response = await http.post(url, body: cliente.toMap());
    if (response.statusCode == 200) {

    } else {
      SnackbarComp.build(context, 'Erro', 'nao foi possivel enviar os dados para api');
      
    }
  }
}
