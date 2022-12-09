import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/app/components/scaffold_comp.dart';
import 'package:e_commerce/app/modules/carrinho/carrinho_controller.dart';
import 'package:e_commerce/app/modules/home/produto_service.dart';
import 'package:e_commerce/app/util/formatacao_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
      carrinhoController: carrinhoController,
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
          FutureBuilder(
            future: produtoService.getAll(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.data == null
                  ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 6),
                      child: Text(
                        'Erro ao buscar produtos',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  'R\$ ${FormatacaoUtil.doubleToReal(snapshot.data[index].valor)}',
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
    );
  }
}
