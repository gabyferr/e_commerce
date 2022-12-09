import 'package:e_commerce/app/components/scaffold_comp.dart';
import 'package:e_commerce/app/modules/carrinho/carrinho_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PagamentoPage extends StatefulWidget {
  const PagamentoPage({Key? key}) : super(key: key);

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  final carrinhoController = Modular.get<CarrinhoController>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldComp(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('TOTAL:'),
                  Text('R\$ 99,99'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Tipos de pagamento:'),
                  DropdownButton<String>(
                    hint: Text('Clique para escolher:'),
                    items: [
                      DropdownMenuItem(child: Text('PIX'), value: 'PIX'),
                      DropdownMenuItem(child: Text('PIX'), value: 'PIX'),
                      DropdownMenuItem(child: Text('PIX'), value: 'PIX'),
                      DropdownMenuItem(child: Text('PIX'), value: 'PIX'),
                      DropdownMenuItem(child: Text('PIX'), value: 'PIX'),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Finalizar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
