import 'package:e_commerce/app/model/usuario_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginController {
  UsuarioModel? userAtual;
  void setUser(UsuarioModel? user) => userAtual = user;
  bool get isLogado => userAtual != null;

  void fazerLogin(String email, String senha) {
    //fazer post na api
    setUser(UsuarioModel(email: email, senha: senha, id: 0, permissao: 1));
    Modular.to.pop();
    Modular.to.pop();
    //se nao erro
  }

  void deslogar() {
    setUser(null);
    Modular.to.pop();
    Modular.to.navigate('/');
  }
}
