import 'package:e_commerce/app/model/usuario_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

class LoginController {
  final userAtual = RxNotifier<UsuarioModel?>(null);
  void setUser(UsuarioModel? user) => userAtual.value = user;
  bool get isLogado => userAtual.value != null;

  String? errorEmail = '';
  String? errorSenha = '';

  void validarEmail(value) {
    if (value.length < 7) {
      errorEmail = 'Email invalido';
    } else {
      errorEmail = null;
    }
  }

  void validarSenha(value) {
    if (value.length < 6) {
      errorSenha = 'Senha invalido';
    } else {
      errorSenha = null;
    }
  }

  Future<bool> fazerLogin(String email, String senha) async {
    if (errorEmail == null && errorSenha == null) {
      //! await fazer post na api
      setUser(UsuarioModel(email: email, senha: senha, id: 0, permissao: 1));
      return true;
    }
    return false;
  }

  void deslogar() {
    setUser(null);
    Modular.to.pop();
    Modular.to.navigate('/');
  }
}
