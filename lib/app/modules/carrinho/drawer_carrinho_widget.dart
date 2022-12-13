import 'package:e_commerce/app/model/endereco_model.dart';
import 'package:e_commerce/app/modules/carrinho/carrinho_controller.dart';
import 'package:e_commerce/app/modules/login/login_controller.dart';
import 'package:e_commerce/app/util/format_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

class DrawerCarrinhoWidget {
  final CarrinhoController carrinhoCtrl;

  DrawerCarrinhoWidget(this.carrinhoCtrl);

  Widget abrirDrawerCarrinho() {
    EnderecoModel? enderecoCliente = Modular.get<LoginController>().userAtual.value?.enderecos.first;
    return Drawer(
      width: 360,
      child: ListView(
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
                RxBuilder(
                  builder: (context) {
                    return Text(
                      'Total R\$: ${FormatUtil.doubleToReal(carrinhoCtrl.total.value)}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          RxBuilder(
            builder: (context) {
              return carrinhoCtrl.itens.value.isEmpty
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
                  : Stepper(
                      elevation: 2,
                      currentStep: carrinhoCtrl.currentStep.value,
                      onStepTapped: (value) => carrinhoCtrl.currentStep.value = value,
                      steps: [
                        Step(
                          isActive: carrinhoCtrl.currentStep.value == 0,
                          title: Text('Itens'),
                          content: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: carrinhoCtrl.itens.value.length,
                            itemBuilder: (context, index) {
                              final item = carrinhoCtrl.itens.value[index].value;
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: CircleAvatar(child: FlutterLogo()),
                                  title: Text(
                                    item!.produto.descricao,
                                  ),
                                  subtitle: Text(
                                    'R\$ ${FormatUtil.doubleToReal(item.total)}',
                                  ),
                                  trailing: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () =>
                                            carrinhoCtrl.alterarQuantidade(
                                                item.produto.id, 1),
                                      ),
                                      Text(
                                        '${item.quantidade}',
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          carrinhoCtrl.alterarQuantidade(
                                            item.produto.id,
                                            0,
                                          );
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Step(
                          isActive: carrinhoCtrl.currentStep.value == 1,
                          title: Text('Entrega'),
                          content: Column(
                            children: [
                               Text('Local: ${enderecoCliente?.descricao}'),
                               Text('Cep: ${enderecoCliente?.cep} | Cidade: ${enderecoCliente?.localidade} | Estado: ${enderecoCliente?.uf}'),
                               Text('Rua: ${enderecoCliente?.logradouro} - Bairro: ${enderecoCliente?.bairro}'),
                            ],
                          )
                        ),
                        Step(
                          isActive: carrinhoCtrl.currentStep.value == 2,
                          title: Text('Pagamento'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RadioListTile(
                                value: 0, 
                                groupValue: carrinhoCtrl.tipoPagamento.value, 
                                title: Text('Dinheiro'),
                                onChanged: (int? value) {
                                  carrinhoCtrl.setPagamento(value!);
                                },
                              ),
                              RadioListTile(
                                value: 1, 
                                groupValue: carrinhoCtrl.tipoPagamento.value, 
                                title: Text('Cartao debito'),
                                onChanged: (int? value) {
                                  carrinhoCtrl.setPagamento(value!);
                                },
                              ),
                              RadioListTile(
                                value: 2, 
                                groupValue: carrinhoCtrl.tipoPagamento.value, 
                                title: Text('Cartao credito'),
                                onChanged: (int? value) {
                                  carrinhoCtrl.setPagamento(value!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                      controlsBuilder:
                          (BuildContext context, ControlsDetails detaisCtrl) {
                        return Container(
                          padding: EdgeInsets.only(top: 22, right: 22),
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            child: Wrap(
                              children: [Icon(Icons.done), Text(' Continuar')],
                            ),
                            onPressed: () async =>
                                await carrinhoCtrl.progressStep(context),
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
