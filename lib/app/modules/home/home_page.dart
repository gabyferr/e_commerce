import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/app/components/scaffold_comp.dart';
import 'package:e_commerce/app/model/produto_model.dart';
import 'package:e_commerce/app/modules/carrinho/carrinho_controller.dart';
import 'package:e_commerce/app/modules/produto/produto_service.dart';
import 'package:e_commerce/app/util/format_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

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

  final produtoService = ProdutoService();
  final carrinhoController = Modular.get<CarrinhoController>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldComp(
      carrinhoCtrl: carrinhoController,
      body: ListView(
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
              autoPlay: true,
              height: MediaQuery.of(context).size.width < 800 ? 280 : 320,
              enlargeCenterPage: true,
            ),
            itemBuilder: (context, index, realIdx) {
              return Center(
                child: Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                  width: 1200,
                ),
              );
            },
          ),
          SizedBox(height: 8),
          FutureBuilder(
            future: produtoService.getAll(),
            builder: (context, AsyncSnapshot<List<ProdutoModel>?> snapshot) {
              return snapshot.data == null
                  ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 6,
                      ),
                      child: Text(
                        'Erro ao buscar produtos',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : RxBuilder(
                      builder: (context) {
                        print(carrinhoController.itens.value.length);
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 342,
                            mainAxisExtent: 220,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                          ),
                          itemBuilder: (context, index) {
                            final produto = snapshot.data![index];
                            final item = carrinhoController.isInListItens(produto.id).value;
                            if (item == null) {
                              return Card(
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlutterLogo(
                                        size: 80,
                                      ),
                                      Text(
                                        produto.descricao,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(Size(270,40))
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'R\$ ${FormatUtil.doubleToReal(produto.valor)}',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Icon(
                                              Icons.shopping_cart_checkout_rounded,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        onPressed: () => carrinhoController.addCarrinho(produto),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Card(
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlutterLogo(
                                        size: 80,
                                      ),
                                      Text(
                                        produto.descricao,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Card(                                      
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        margin: EdgeInsets.zero,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.red,
                                              ),
                                              onPressed: () =>carrinhoController .alterarQuantidade(produto.id, 1),
                                            ),
                                            Text(
                                              '${item.quantidade}',
                                            ),
                                            IconButton(
                                              onPressed: () => carrinhoController.alterarQuantidade(produto.id, 0),    
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
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
