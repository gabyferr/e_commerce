import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
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
      body: Stack(
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
          GridView.builder(
            itemCount: 18,
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 160,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) => GestureDetector(
              child: Card(
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      FlutterLogo(
                        size: 80,
                      ),
                      Text(
                        'produto',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () => abrirModalDetalheProduto(),
            ),
          ),
        ],
      ),
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
}
