import 'package:e_commerce/app/model/cliente_model.dart';
import 'package:e_commerce/app/model/endereco_model.dart';
import 'package:e_commerce/app/model/usuario_model.dart';
import 'package:e_commerce/app/modules/carrinho/carrinho_controller.dart';
import 'package:e_commerce/app/modules/carrinho/drawer_carrinho_widget.dart';
import 'package:e_commerce/app/modules/cliente/cliente_controller.dart';
import 'package:e_commerce/app/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ScaffoldComp extends StatelessWidget {
  final Widget body;
  final CarrinhoController? carrinhoCtrl;

  const ScaffoldComp({
    Key? key,
    required this.body,
    this.carrinhoCtrl,
  }) : super(key: key);

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
            title: carrinhoCtrl != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        print(value);
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Container(
                          padding: EdgeInsets.only(right: 12),
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
                  )
                : SizedBox.shrink(),
            actions: [
              if (carrinhoCtrl != null) ...[
                if (MediaQuery.of(context).size.width > 800 &&
                    !Modular.get<LoginController>().isLogado) ...[
                  Builder(builder: (context) {
                    return InkWell(
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
                      onTap: () => Scaffold.of(context).openDrawer(),
                    );
                  }),
                ],
                RxBuilder(
                  builder: (context) {
                    return IconButton(
                      padding: EdgeInsets.only(right: 26),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Stack(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 36,
                            color: Colors.white,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: CircleAvatar(
                              child: Text(
                                '${carrinhoCtrl!.itens.value.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              backgroundColor: Colors.red,
                              maxRadius: 10,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
          drawer: drawerMenu(context),
          endDrawer: carrinhoCtrl != null
              ? DrawerCarrinhoWidget(carrinhoCtrl!).abrirDrawerCarrinho()
              : null,
          body: body,
        ),
      ],
    );
  }

  Widget drawerMenu(BuildContext context) {
    final loginCtrl = Modular.get<LoginController>();

    return RxBuilder(builder: (context) {
      return Drawer(
        child: ListView(
          children: [
            SizedBox(
              width: 360,
              height: 200,
              child: Image.asset(
                'assets/img/logo.png',
              ),
            ),
            if (loginCtrl.isLogado) ...[
              if (Modular.to.path == '/painel') ...[
                ListTile(
                  title: Text('Home'),
                  onTap: () => Modular.to.navigate('/'),
                ),
              ] else if (loginCtrl.isLogado) ...[
                ListTile(
                  title: Text('Painel'),
                  onTap: () => Modular.to.navigate('/painel'),
                ),
              ],
              ListTile(
                title: Text('Sair'),
                onTap: () {
                  loginCtrl.deslogar();
                },
              ),
            ] else ...[
              ListTile(
                title: Text('Login'),
                onTap: () => abrirModalLogin(context),
              ),
              ListTile(
                title: Text('Cadastro'),
                onTap: () => abrirModalCadastro(context),
              )
            ],
          ],
        ),
      );
    });
  }

  static Future<bool?> abrirModalLogin(BuildContext context) async {
    final loginCtrl = Modular.get<LoginController>();
    bool? isCompleted;
    TextEditingController emailText = TextEditingController(text: '');
    TextEditingController senhaText = TextEditingController(text: '');

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Login'),
              content: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  TextField(
                    controller: emailText,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'e-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      errorText: loginCtrl.errorEmail,
                    ),
                    onChanged: (value) {
                      loginCtrl.validarEmail(value);
                      setState(() {});
                    },
                  ),
                  TextField(
                    controller: senhaText,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      errorText: loginCtrl.errorSenha,
                    ),
                    onChanged: (value) {
                      loginCtrl.validarSenha(value);
                      setState(() {});
                    },
                  ),
                ],
              ),
              actions: [
                OutlinedButton(
                  child: Text('Entrar'),
                  onPressed: () async {
                    await loginCtrl.fazerLogin(
                        UsuarioModel(
                            email: emailText.text,
                            senha: senhaText.text,
                            permissao: 1),
                        context);
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 8, 22, 218),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Color.fromARGB(255, 49, 6, 241),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
    return isCompleted;
  }

  static void abrirModalCadastro(context) {
    TextEditingController nomeTEdt = TextEditingController();
    TextEditingController emailTEdt = TextEditingController();
    TextEditingController senhaTEdt = TextEditingController();
    TextEditingController cepTEdt = TextEditingController();
    TextEditingController cidadeTEdt = TextEditingController();
    TextEditingController estadoTEdt = TextEditingController();
    TextEditingController ruaTEdt = TextEditingController();
    TextEditingController numeroTEdt = TextEditingController();
    TextEditingController bairroTEdt = TextEditingController();
    TextEditingController nomeEnderecoTEdt = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Cadastro'),
          content: Container(
            width: 400,
            height: 360,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 12.0,
                children: [
                  SizedBox(height: 8),
                  TextField(
                    controller: nomeTEdt,
                    decoration: InputDecoration(
                      label: Text('Nome'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailTEdt,
                    decoration: InputDecoration(
                      label: Text('E-mail'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: senhaTEdt,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Senha'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  Divider(),
                  TextField(
                    controller: nomeEnderecoTEdt,
                    decoration: InputDecoration(
                      label: Text('Nome para o local'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: cepTEdt,
                    decoration: InputDecoration(
                      label: Text('Cep'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: cidadeTEdt,
                          decoration: InputDecoration(
                            label: Text('Cidade'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: estadoTEdt,
                          decoration: InputDecoration(
                            label: Text('Estado'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: ruaTEdt,
                          decoration: InputDecoration(
                            label: Text('Rua'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: numeroTEdt,
                          decoration: InputDecoration(
                            label: Text('Numero'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: bairroTEdt,
                    decoration: InputDecoration(
                      label: Text('Bairro'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              child: Text('Salvar'),
              onPressed: () async {
                await Modular.get<ClienteController>().cadastrar(
                  ClienteModel(
                    nome: nomeTEdt.text,
                    usuario: UsuarioModel(
                      email: emailTEdt.text,
                      senha: senhaTEdt.text,
                      permissao: 0,
                    ),
                    enderecos: [
                      EnderecoModel(
                        descricao: nomeEnderecoTEdt.text,
                        cep: cepTEdt.text,
                        bairro: bairroTEdt.text,
                        logradouro: ruaTEdt.text,
                        localidade: cidadeTEdt.text,
                        uf: estadoTEdt.text,
                      )
                    ],
                  ),
                  context,
                );
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 8, 22, 218),
                ),
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: Color.fromARGB(255, 49, 6, 241),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
