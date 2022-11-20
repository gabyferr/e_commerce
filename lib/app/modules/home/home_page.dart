import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/app/components/drawer_menu_comp.dart';
import 'package:e_commerce/app/model/produto_model.dart';

import 'package:e_commerce/app/services/produto_service.dart';
import 'package:e_commerce/app/util/formatacao_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../carrinho/carrinho_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    'assets/img/imgC1.jpg',
    'assets/img/imgC2.jpg',
    'assets/img/imgC3.jpg',
    'assets/img/imgC4.jpg',
  ];
  double valorProd = 10000.00;

  final produtoService = ProdutoService();
  final carrinhoController = Modular.get<CarrinhoController>();

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
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Container(
                          padding: EdgeInsets.only(right: 12),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              if (MediaQuery.of(context).size.width > 800) ...[
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.login,
                        color: Colors.white,
                        size: 28,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 18),
                        child: Text(
                          'Faça seu login.\nOu cadastre-se!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () => DrawerMenuComp.abrirModalLogin(context),
                ),
              ],
              Builder(
                builder: (context) {
                  return IconButton(
                    padding: EdgeInsets.only(right: 26),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: 32,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
          drawer: DrawerMenuComp(),
          endDrawer: abrirDrawerCarrinho(),
          body: ListView(
            children: [
              CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  autoPlay: true,
                  height: 280,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Center(
                    child: Image.asset(
                      images[index],
                      width: 1200,
                    ),
                  );
                },
              ),
              FutureBuilder(
                future: produtoService.getAll(),
                builder: (context, AsyncSnapshot snapshot) {
                  return snapshot.data == null
                      ? Center(
                          child: Text('Erro ao buscar produtos'),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 280,
                            mainAxisExtent: 240,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FlutterLogo(
                                      size: 80,
                                    ),
                                    Text(
                                      snapshot.data[index].nome,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'R\$ ${FormatacaoUtil.doblueToReal(snapshot.data[index].valor)}',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.blue,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      title: Text('Add carrinho'),
                                      contentPadding: EdgeInsets.only(left: 6),
                                      minLeadingWidth: 0,
                                      onTap: () {
                                        carrinhoController
                                            .addCarrinho(snapshot.data[index]);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

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
                    'Total R\$: ${FormatacaoUtil.doblueToReal(carrinhoController.total.value)}',
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
              return produtosNoCarrinho.isEmpty
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
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: ScrollController(),
                      itemCount: produtosNoCarrinho.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: CircleAvatar(child: FlutterLogo()),
                          title: Text(produtosNoCarrinho[index].value!.nome),
                          subtitle: Text(
                              'R\$ ${FormatacaoUtil.doblueToReal(carrinhoController.itens.value[index].value!.valor)}'),
                          trailing: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    carrinhoController.alterarQuantidade(
                                        produtosNoCarrinho[index].value!.id, 1);
                                  },
                                  icon: Icon(Icons.remove)),
                              RxBuilder(builder: (context) {
                                return Text(
                                    '${produtosNoCarrinho[index].value!.quantidade}');
                              }),
                              IconButton(
                                  onPressed: () {
                                    carrinhoController.alterarQuantidade(
                                        produtosNoCarrinho[index].value!.id, 0);
                                  },
                                  icon: Icon(Icons.add)),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          ),
          Container(
            margin: EdgeInsets.all(12),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                carrinhoController.salvarCarrinho();
              },
            ),
          )
        ],
      ),
    );
  }
}
