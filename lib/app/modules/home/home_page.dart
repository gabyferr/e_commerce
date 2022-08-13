import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  double valorProd = 10000.00;

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
                  onTap: () => abrirModalLogin(),
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
          drawer: abrirDrawerMenu(),
          endDrawer: abrirDrawerCarrinho(),
          body: ListView(
            children: [
              CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                    child: Center(
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                  );
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  itemCount: 18,
                  padding: EdgeInsets.all(12),
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
                              'descrição produto',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'R\$ $valorProd',
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
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () => abrirModalDetalheProduto(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void abrirModalLogin() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login'),
          content: Wrap(
            children: [
              Text('colocar as descricoes.....'),
            ],
          ),
        );
      },
    );
  }

  void abrirModalDetalheProduto() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detalhes do produto'),
          content: Wrap(
            children: [
              IconButton(onPressed: () => addCarrinho(), icon: Icon(Icons.add)),
              Text('colocar as descricoes.....'),
            ],
          ),
        );
      },
    );
  }

  Widget abrirDrawerMenu() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Menu'),
          ),
          ListTile(
            title: Text('Login/Cadastro'),
            onTap: () => abrirModalLogin(),
          ),
          ExpansionTile(
            title: Text('Categorias'),
            children: [
              ListTile(
                title: Text('Acucares'),
              ),
              ListTile(
                title: Text('Bebidas'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget abrirDrawerCarrinho() {
    return Drawer();
  }

  void addCarrinho() {
    //fazer uma classe controller para o carrinho e passa essa funcao para la!!
  }
}
