import 'package:e_commerce/app/modules/carrinho.dart/carrinho_controller.dart';
import 'package:e_commerce/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((_) => CarrinhoController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage()),
      ];
}
