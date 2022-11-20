import 'package:e_commerce/app/model/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CarrinhoController extends ChangeNotifier {
  final itens = RxNotifier<List<RxNotifier<ProdutoModel?>>>([]);

  void addCarrinho(ProdutoModel produto) {
    if (!alterarQuantidade(produto.id, 0)) {
      produto.quantidade = 1;
      itens.value.add(RxNotifier(produto));
      calculaTotal();
    }
  }

  void removerCarrinho(int id) {
    itens.value.removeWhere((item) => item.value?.id == id);
    itens.notifyListeners();
  }

  bool alterarQuantidade(int id, int operacao) {
    bool existe = false;
    RxNotifier<ProdutoModel?> item = itens.value.firstWhere(
        (item) => item.value!.id == id,
        orElse: () => RxNotifier(null));
    if (item.value != null) {
      if (operacao == 0) {
        item.value!.quantidade++;
      } else if (item.value!.quantidade > 1) {
        item.value!.quantidade--;
      } else {
        removerCarrinho(id);
      }
      item.notifyListeners();
      calculaTotal();
      existe = true;
    }
    return existe;
  }

  final total = RxNotifier<double>(0);
  void calculaTotal() {
    double value = 0;
    for (RxNotifier<ProdutoModel?> item in itens.value) {
      value += (item.value?.valor ?? 0) * (item.value?.quantidade ?? 0);
    }
    total.value = value;
  }

  void salvarCarrinho() {
    //verificar se o cliente ta logado
    //se tiver logado mostrar modal para escolher o tipo de pagamento
    //se nao chamar modal de login
    Modular.to.navigate('/painel');
  }
}
