import 'package:e_commerce/app/model/cliente_model.dart';
import 'package:e_commerce/app/model/endereco_model.dart';
import 'package:e_commerce/app/model/usuario_model.dart';
import 'package:e_commerce/app/modules/cliente/cliente_controller.dart';
import 'package:e_commerce/app/modules/login/login_controller.dart';
import 'package:e_commerce/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerMenuComp extends StatelessWidget {
  DrawerMenuComp({Key? key}) : super(key: key);

  final loginCtrl = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 46,
                  child: Image.asset(
                    'assets/img/logo.png',
                  ),
                ),
                Text('Menu', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          if (Modular.to.path == '/painel') ...[
            ListTile(
              title: Text('Home'),
              onTap: () => Modular.to.navigate('/'),
            ),
          ] else ...[
            ListTile(
              title: Text('Painel'),
              onTap: () => Modular.to.navigate('/painel'),
            ),
          ],
          if (!loginCtrl.isLogado) ...[
            ListTile(
              title: Text('Login'),
              onTap: () => abrirModalLogin(context),
            ),
            ListTile(
              title: Text('Cadastro'),
              onTap: () => abrirModalCadastro(context),
            )
          ] else ...[
            ListTile(
              title: Text('Sair'),
              onTap: () {
                loginCtrl.deslogar();
              },
            ),
          ],
        ],
      ),
    );
  }

  static void abrirModalLogin(BuildContext context) {
    final loginStore = LoginStore();
    TextEditingController emailText = TextEditingController();
    TextEditingController senhaText = TextEditingController();

    showDialog(
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
                      errorText: loginStore.errorEmail,
                    ),
                    onChanged: (value) {
                      loginStore.validarEmail(value);
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
                      errorText: loginStore.errorSenha,
                    ),
                    onChanged: (value) {
                      loginStore.validarSenha(value);
                      setState(() {});
                    },
                  ),
                ],
              ),
              actions: [
                OutlinedButton(
                  child: Text('Login'),
                  onPressed: () {
                    if (loginStore.errorEmail == null &&
                        loginStore.errorSenha == null) {
                      Modular.get<LoginController>()
                          .fazerLogin(emailText.text, senhaText.text);
                    }
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
  }

  static void abrirModalCadastro(context) {
    TextEditingController nomeTEdt = TextEditingController();
    TextEditingController emailTEdt = TextEditingController();
    TextEditingController senhaTEdt = TextEditingController();
    TextEditingController confirmiSenhaTEdt = TextEditingController();

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
                  TextField(
                    controller: nomeTEdt,
                    decoration: InputDecoration(
                      label: Text('nome'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailTEdt,
                    decoration: InputDecoration(
                      label: Text('e-mail'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: senhaTEdt,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('senha'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: confirmiSenhaTEdt,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('confirmi senha'),
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
                  TextField(
                    controller: cidadeTEdt,
                    decoration: InputDecoration(
                      label: Text('Cidade'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: estadoTEdt,
                    decoration: InputDecoration(
                      label: Text('Estado'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
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
                            label: Text('numero'),
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
                      label: Text('bairro'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: nomeEnderecoTEdt,
                    decoration: InputDecoration(
                      label: Text('Nome do endereco'),
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
              onPressed: () {
                Modular.get<ClienteController>().cadastrar(
                  ClienteModel(
                    id: 0,
                    nome: nomeEnderecoTEdt.text,
                    usuario: UsuarioModel(
                        id: 0,
                        email: emailTEdt.text,
                        senha: senhaTEdt.text,
                        permissao: 0),
                    enderecos: [
                      EnderecoModel(
                        id: 0,
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
