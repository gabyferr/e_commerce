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
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        toolbarHeight: 82,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CircleAvatar(
            radius: 26,
            child: Image.asset(
              'assets/img/logo.png',
            ),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 36,
                ),
                padding: EdgeInsets.only(right: 28),
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
            Row(
              children: [
                CircleAvatar(
                  child: FlutterLogo(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Faça seu login.\nOu cadastre-se!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
          IconButton(
            padding: EdgeInsets.only(right: 16),
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 32,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Drawer(),
      body: GridView.builder(
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
          crossAxisSpacing: 8,
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
    );
  }

  void abrirModalDetalheProduto() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detalhes do produto'),
          content: Column(children: [Text('descricoess.....')]),
        );
      },
    );
  }
}
