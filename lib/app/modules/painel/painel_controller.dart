import 'package:e_commerce/app/model/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

class PainelController extends ChangeNotifier {
  final itens = RxNotifier<List<RxNotifier<ProdutoModel?>>>([]);

  void abrirMenu() {
    Modular.to.navigate('/menu');
  }
}
