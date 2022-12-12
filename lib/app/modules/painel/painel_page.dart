import 'package:e_commerce/app/components/scaffold_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PainelPage extends StatefulWidget {
  const PainelPage({Key? key}) : super(key: key);

  @override
  State<PainelPage> createState() => _PainelPageState();
}

class _PainelPageState extends State<PainelPage> {
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
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('data do pedio'),
                      subtitle: Text('valor'),
                      trailing: IconButton(
                        icon: Icon(Icons.open_in_new),
                        onPressed: () => modalDetalhesPedido(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void modalDetalhesPedido() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Detalhes do pedido:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Wrap(
            children: [
              Text('detalhes'),
              Text('detalhes'),
              Text('detalhes'),
              Text('detalhes'),
              Text('detalhes'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Voltar'),
            ),
          ],
        ).build(context);
      },
    );
  }
}
