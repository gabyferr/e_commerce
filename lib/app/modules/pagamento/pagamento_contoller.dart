import 'package:e_commerce/app/model/produto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

class PagamentoController extends ChangeNotifier {
  final itens = RxNotifier<List<RxNotifier<ProdutoModel?>>>([]);

  void finalizarPedido(BuildContext context) {
    Modular.to.navigate('/pagamento');
  }
}
