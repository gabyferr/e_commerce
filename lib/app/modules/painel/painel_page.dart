import 'package:e_commerce/app/components/drawer_menu_comp.dart';
import 'package:e_commerce/app/modules/login/login_controller.dart';
import 'package:e_commerce/app/pagamento/pagamento_contoller.dart';
import 'package:e_commerce/app/pagamento/pagamento_page.dart';
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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueAccent,
                Colors.white,
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          drawerEnableOpenDragGesture: false,
          drawer: DrawerMenuComp(),
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            toolbarHeight: 82,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
                    size: 36,
                  ),
                  padding: EdgeInsets.only(left: 26),
                );
              },
            ),
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.topCenter,
              constraints: BoxConstraints(maxWidth: 800),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('data do pedio'),
                      subtitle: Text('valor'),
                      trailing: IconButton(
                        icon: Icon(Icons.open_in_new),
                        onPressed: () {
                          //! abrir uma modal qe mostre todos os dados do pedido
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
