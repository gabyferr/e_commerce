import 'package:e_commerce/app/model/cliente_model.dart';

import 'package:http/http.dart' as http;

class ClienteController {
  void cadastrar(ClienteModel cliente) async {
    Uri url = Uri.http('localhost:3000', '/cliente');
    http.Response response = await http.post(url, body: cliente.toMap());
    print(response.body);
  }
}
