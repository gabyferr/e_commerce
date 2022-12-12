import 'package:e_commerce/app/components/scaffold_comp.dart';
import 'package:e_commerce/app/components/snackbar_comp.dart';
import 'package:e_commerce/app/model/item_pedido_model.dart';
import 'package:e_commerce/app/model/produto_model.dart';
import 'package:e_commerce/app/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CarrinhoController extends ChangeNotifier {
  final itens = RxNotifier<List<RxNotifier<ItemPedidoModel?>>>([]);

  void addCarrinho(ProdutoModel produto) {
    if (!alterarQuantidade(produto.id, 0)) {
      itens.value.add(RxNotifier(ItemPedidoModel(
        quantidade: 1,
        produto: produto,
        total: produto.valor
      )));
      calculaTotal();
    }
  }

  void removerCarrinho(int id) {
    itens.value.removeWhere((item) => item.value!.produto.id == id);
    itens.notifyListeners();
  }

  bool alterarQuantidade(int id, int operacao) {
    bool existe = false; 
    RxNotifier<ItemPedidoModel?> item = isInListItens(id);
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
    itens.notifyListeners();
    return existe;
  }

  final total = RxNotifier<double>(0);
  void calculaTotal() {
    double value = 0;
    for (RxNotifier<ItemPedidoModel?> item in itens.value) {
      value += (item.value?.total ?? 0) * (item.value?.quantidade ?? 0);
    }
    total.value = value;
  }

  RxNotifier<ItemPedidoModel?> isInListItens(int id) => itens.value.firstWhere((item) => item.value!.produto.id == id, orElse: () => RxNotifier(null));

  final currentStep = RxNotifier<int>(0);
  Future<void> progressStep(BuildContext context) async {
    if (currentStep.value == 0 && !Modular.get<LoginController>().isLogado) {
      if (!(await ScaffoldComp.abrirModalLogin(context) ?? false)) {
        SnackbarComp.build(context, 'Atenção', 'Usuario ou senha incorretos');
        return;
      }
    }
    if (currentStep.value == 2) {
      //! enviar pedido para a api
      Modular.dispose<CarrinhoController>();
      return Modular.to.navigate('/painel');
    }
    currentStep.value++;
  }
}
