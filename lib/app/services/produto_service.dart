import 'dart:convert';

import 'package:e_commerce/app/model/produto_model.dart';
import 'package:http/http.dart' as http;

class ProdutoService {
  Future<List<ProdutoModel>?> getAll() async {
    var url = Uri.http('192.168.100.140:3000', '/produtos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      List dados = jsonDecode(response.body);
      return dados
          .map((e) => ProdutoModel.fromMap(e))
          .toList()
          .cast<ProdutoModel>();
    }
    //aqui dispara a msg de erro
    return [];
  }
}
