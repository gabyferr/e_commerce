import 'package:e_commerce/app/model/produto_model.dart';

class PedidoModel {
  int id;
  String? nomeCliente; //mudar para o obj model o cliente
  double total;
  List<ProdutoModel> itens;

  PedidoModel({
    required this.id,
    this.nomeCliente,
    required this.itens,
    required this.total,
  });
}
