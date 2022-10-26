import 'package:e_commerce/app/model/produto_model.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CarrinhoController {
  final itens = RxNotifier<List<ProdutoModel>>([]).asRx();

  void addCarrinho(ProdutoModel produto) {
    if (!alterarQuantidade(produto)) {
      itens.value.add(produto);
    }
  }

  void removerCarrinho(ProdutoModel produto) {
    itens.value.remove(produto);
  }

  bool alterarQuantidade(ProdutoModel produto, [int? quantidade]) {
    bool existe = false;
    itens.value.map((item) {
      if (item.id == produto.id) {
        item.quantidade++;
        existe = true;
      }
      return item;
    }).toList();
    return existe;
    //quando o item for igual ao meu produto ai eu altero a quantidade dele;
  }
}
