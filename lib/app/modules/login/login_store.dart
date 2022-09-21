class LoginStore {
  String? errorEmail = '';
  String? errorSenha = '';

  void validarEmail(value) {
    if (value.length < 10) {
      errorEmail = 'Email invalido';
    } else {
      errorEmail = null;
    }
  }

  void validarSenha(value) {
    if (value.length < 7) {
      errorSenha = 'Senha invalido';
    } else {
      errorSenha = null;
    }
  }
}
