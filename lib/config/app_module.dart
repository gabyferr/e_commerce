import 'package:e_commerce/app/modules/home/home_page.dart';
import 'package:e_commerce/app/modules/painel/painel_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../app/modules/carrinho/carrinho_controller.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((_) => CarrinhoController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage()),
        ChildRoute('/painel', child: (context, args) => PainelPage()),
      ];
}
