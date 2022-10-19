import 'package:e_commerce/app/model/produto_model.dart';

class ProdutoService {
  List<ProdutoModel> getAll() {
    return [
      ProdutoModel(id: 0, nome: 'Chocolate', quantidade: 0, valor: 99.99),
      ProdutoModel(id: 1, nome: 'maca', quantidade: 0, valor: 19.99),
      ProdutoModel(id: 2, nome: 'pera', quantidade: 0, valor: 39.99),
      ProdutoModel(id: 3, nome: 'mamao', quantidade: 0, valor: 29.99),
      ProdutoModel(id: 4, nome: 'morango', quantidade: 0, valor: 9.99),
    ];
  }
}
