import 'package:e_commerce/app/components/scaffold_comp.dart';
import 'package:e_commerce/app/model/produto_model.dart';
import 'package:e_commerce/app/modules/carrinho/carrinho_controller.dart';
import 'package:e_commerce/app/modules/login/login_controller.dart';
import 'package:e_commerce/app/util/formatacao_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

class DrawerCarrinhoWidget {
  final CarrinhoController carrinhoController;

  DrawerCarrinhoWidget(this.carrinhoController);

  Widget abrirDrawerCarrinho() {
    return Drawer(
      child: ListView(
        controller: ScrollController(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'Carrinho de compras',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 36,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 54,
                    color: Colors.red,
                  ),
                ),
                RxBuilder(builder: (context) {
                  return Text(
                    'Total R\$: ${FormatacaoUtil.doubleToReal(carrinhoController.total.value)}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                })
              ],
            ),
          ),
          RxBuilder(
            builder: (context) {
              List<RxNotifier<ProdutoModel?>> produtosNoCarrinho =
                  carrinhoController.itens.value;
              return !produtosNoCarrinho.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ops !!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Nenhum produto no carrinho',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          controller: ScrollController(),
                          itemCount: produtosNoCarrinho.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              leading: CircleAvatar(child: FlutterLogo()),
                              title:
                                  Text(produtosNoCarrinho[index].value!.nome),
                              subtitle: Text(
                                  'R\$ ${FormatacaoUtil.doubleToReal(carrinhoController.itens.value[index].value!.valor)}'),
                              trailing: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        carrinhoController.alterarQuantidade(
                                            produtosNoCarrinho[index].value!.id,
                                            1);
                                      },
                                      icon: Icon(Icons.remove)),
                                  RxBuilder(builder: (context) {
                                    return Text(
                                        '${produtosNoCarrinho[index].value!.quantidade}');
                                  }),
                                  IconButton(
                                      onPressed: () {
                                        carrinhoController.alterarQuantidade(
                                            produtosNoCarrinho[index].value!.id,
                                            0);
                                      },
                                      icon: Icon(Icons.add)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(12),
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            child: Text('Salvar'),
                            onPressed: () {
                              if (!Modular.get<LoginController>().isLogado) {
                                return ScaffoldComp.abrirModalLogin(context);
                              }
                              carrinhoController.salvarCarrinho(context);
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}
