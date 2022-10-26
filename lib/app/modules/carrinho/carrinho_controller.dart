import 'package:e_commerce/app/model/produto_model.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CarrinhoController {
  final itens = RxNotifier<List<ProdutoModel>>([]).asRx();

  void addCarrinho(ProdutoModel produto) {
    itens.value.add(produto);
  }

  void removerCarrinho(ProdutoModel produto) {
    itens.value.remove(produto);
  }

  void alterarQuantidade(ProdutoModel produto, int quantidade) {
    itens.value.map((item) => item).toList();
    //quando o item for igual ao meu produto ai eu altero a quantidade dele;
  }
}
