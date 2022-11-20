import 'package:e_commerce/app/components/drawer_menu_comp.dart';
import 'package:flutter/material.dart';

class PainelPage extends StatefulWidget {
  const PainelPage({Key? key}) : super(key: key);

  @override
  State<PainelPage> createState() => _PainelPageState();
}

class _PainelPageState extends State<PainelPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          leading: Builder(builder: (context) {
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
          }),
          title: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: CircleAvatar(
                    radius: 26,
                    child: Image.asset(
                      'assets/img/logo.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            itemCount: 8,
            itemBuilder: (context, index) => Card(
                  child: Text('gtyh'),
                )),
      ),
    ]);
  }
}
