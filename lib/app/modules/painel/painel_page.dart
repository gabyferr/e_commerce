import 'package:e_commerce/app/components/scaffold_comp.dart';
import 'package:e_commerce/app/model/pedido_model.dart';
import 'package:e_commerce/app/modules/painel/painel_controller.dart';
import 'package:e_commerce/app/util/format_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PainelPage extends StatefulWidget {
  const PainelPage({Key? key}) : super(key: key);

  @override
  State<PainelPage> createState() => _PainelPageState();
}

class _PainelPageState extends State<PainelPage> {
  final painelCtrl = Modular.get<PainelController>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldComp(
      body: ListView(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.topCenter,
              constraints: BoxConstraints(maxWidth: 800),
              child: FutureBuilder(
                future: painelCtrl.buscarPedidosCliente(),
                builder: (BuildContext context, AsyncSnapshot<List<PedidoModel>?> snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      PedidoModel pedido = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          title: Text(pedido.dataEfetuado),
                          subtitle: Text(FormatUtil.doubleToReal(pedido.total)),
                          trailing: IconButton(
                            icon: Icon(Icons.open_in_new),
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
